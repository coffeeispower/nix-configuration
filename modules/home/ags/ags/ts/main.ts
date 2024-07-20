const hours = Variable(new Date, {
    poll: [1000 * 60, () => new Date],
})

const ClockHours = (/** @type {number} */ monitor) => Widget.Window({
    monitor,
    name: `clock${monitor}`,
    anchor: ['left'],
    margins: [0, 100],
    clickThrough: true,
    layer: "bottom",
    exclusivity: 'ignore',
    keymode: "none",
    widthRequest: 1,
    className: "time",
    child: Widget.Box(
        {
            vertical: true,
            children: [
                Widget.Label({
                    className: "hours",
                    label: hours.bind().as((hours) => hours.toLocaleTimeString(undefined, {hour: "2-digit", minute: "2-digit"}))
                }),
            ]
        }
    ),
})


const DateWidget = (/** @type {number} */ monitor) => Widget.Window({
    monitor,
    name: `widget${monitor}`,
    anchor: ['right'],
    margins: [0, 100],
    clickThrough: true,
    layer: "bottom",
    exclusivity: 'ignore',
    keymode: "none",
    widthRequest: 1,
    className: "time",
    child: Widget.Box({
        vertical: true,
        children: [
            Widget.Label({
                className: "weekday",
                label: hours.bind().as((hours) => hours.toLocaleDateString(undefined, {
                    weekday: "short",
                }))
            }),
            Widget.Label({
                className: "date",
                label: hours.bind().as((hours) => hours.toLocaleDateString(undefined, {
                    day: "numeric",
                    month: "2-digit",
                    year: "numeric",
                }))
            }),
        ]
    }),
})

App.config({
    windows: [ClockHours(0), DateWidget(0)],
    style: App.configDir + "/ts/style.css"
})
