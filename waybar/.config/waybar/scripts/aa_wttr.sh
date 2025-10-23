#!/usr/bin/zsh
## Convert slstatrus to json using awk

# Ive created an slstatus that splits the outputs with a + symbol
# Then i split the up and down by spaces to get the units of each
# Units are then converted into a class to use for styling

snore() {
    if [[ -n $1 ]]; then
        ( zselect -t $(( $1*100 )) ) &>/dev/null || return 0
    fi
    return 1
}

TIMEOUT=60

while snore "$TIMEOUT"; do
    SLSFILE=$(curl --silent wttr.in/canberra\?format=j1)

    echo "$SLSFILE" | jq --unbuffered --compact-output '
    def parse_time: gsub(" "; "") | strptime("%I:%M%p") | mktime;
    def format_suntime:
    if . > 0 then "\(. / 60 | floor) mins longer"
    elif . < 0 then "\(-. / 60 | floor) mins shorter"
    else "No change in suntime" end;
    {
    feelslikec: .current_condition[0].FeelsLikeC,
    humidity: .current_condition[0].humidity,
    precipmm: .current_condition[0].precipMM,
    tempc: .current_condition[0].temp_C,
    today_maxtempc: .weather[0].maxtempC,
    today_mintempc: .weather[0].mintempC,
    today_sunrise: .weather[0].astronomy[0].sunrise,
    today_sunset: .weather[0].astronomy[0].sunset,
    tomorrow_maxtempc: .weather[1].maxtempC,
    tomorrow_mintempc: .weather[1].mintempC,
    tomorrow_sunrise: .weather[1].astronomy[0].sunrise,
    tomorrow_sunset: .weather[1].astronomy[0].sunset,
    weatherdesc: .current_condition[0].weatherDesc[0].value,
    maxtemp_delta: ((.weather[1].maxtempC | tonumber) - (.weather[0].maxtempC | tonumber)) | (if . > 0 then "+\(.)" else tostring end),
    feelslike_delta: ((.current_condition[0].FeelsLikeC| tonumber) - (.current_condition[0].temp_C| tonumber)) | (if . > 0 then "+\(.)" else tostring end),
    mintemp_delta: ((.weather[1].mintempC | tonumber) - (.weather[0].mintempC | tonumber)) | (if . > 0 then "+\(.)" else tostring end),
    sunrise_delta_mins: (((.weather[1].astronomy[0].sunrise | parse_time) - (.weather[0].astronomy[0].sunrise | parse_time)) / 60) | (if . > 0 then "+\(.)" else tostring end),
    sunset_delta_mins: (((.weather[1].astronomy[0].sunset | parse_time) - (.weather[0].astronomy[0].sunset | parse_time)) / 60) | (if . > 0 then "+\(.)" else tostring end),
    day_lenght_delta: (((.weather[1].astronomy[0].sunset | parse_time) - (.weather[0].astronomy[0].sunset | parse_time)) - ((.weather[1].astronomy[0].sunrise | parse_time) - (.weather[0].astronomy[0].sunrise | parse_time))) | format_suntime,
    } | {
        text: "\(.feelslikec)[\(.feelslike_delta)]°C ( \(.humidity)%) (TMRW: \(.tomorrow_mintempc)[\(.mintemp_delta)]°C to \(.tomorrow_maxtempc)[\(.maxtemp_delta)]°C)",
    alt: .weatherdesc,
    class: (
        if (.feelslikec | tonumber) < 10 then "blue"
        elif (.feelslikec | tonumber) <= 25 then "green"
        elif (.feelslikec | tonumber) <= 30 then "yellow"
        elif (.feelslikec | tonumber) <= 35 then "orange"
        else "red"
        end
    )
    }'

    sleep 3600
done
