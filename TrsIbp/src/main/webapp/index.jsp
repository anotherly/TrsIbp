<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- saved from url=(0126)file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html# -->
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DevSync - IT 개발사 스마트 대시보드</title>
    <!-- Tailwind CSS CDN -->
    <script src="./protoType/saved_resource"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        brand: {
                            dark: '#0b0f19',      /* Deep background space */
                            card: '#111827',      /* Dark Card */
                            border: '#1f2937',    /* Card border */
                            accent: '#3b82f6',    /* Theme Blue */
                            neonBlue: '#00d2ff',  /* Cool developer cyan */
                            neonGreen: '#10b981'  /* Success state green */
                        }
                    },
                    fontFamily: {
                        sans: ['Inter', 'Noto Sans KR', 'sans-serif'],
                    }
                }
            }
        }
    </script>
    <!-- Google Fonts & FontAwesome -->
    <link rel="preconnect" href="https://fonts.googleapis.com/">
    <link rel="preconnect" href="https://fonts.gstatic.com/" crossorigin="">
    <link href="./DevSync - IT 개발사 스마트 대시보드_files/css2" rel="stylesheet">
    <link rel="stylesheet" href="./DevSync - IT 개발사 스마트 대시보드_files/all.min.css">
    
    <style>
        body {
            font-family: 'Inter', 'Noto Sans KR', sans-serif;
            background-color: #0b0f19;
            color: #f3f4f6;
            overflow-x: hidden;
        }
        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 6px;
            height: 6px;
        }
        ::-webkit-scrollbar-track {
            background: #0b0f19;
        }
        ::-webkit-scrollbar-thumb {
            background: #1f2937;
            border-radius: 4px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #3b82f6;
        }
    </style>
<style>*, ::before, ::after{--tw-border-spacing-x:0;--tw-border-spacing-y:0;--tw-translate-x:0;--tw-translate-y:0;--tw-rotate:0;--tw-skew-x:0;--tw-skew-y:0;--tw-scale-x:1;--tw-scale-y:1;--tw-pan-x: ;--tw-pan-y: ;--tw-pinch-zoom: ;--tw-scroll-snap-strictness:proximity;--tw-gradient-from-position: ;--tw-gradient-via-position: ;--tw-gradient-to-position: ;--tw-ordinal: ;--tw-slashed-zero: ;--tw-numeric-figure: ;--tw-numeric-spacing: ;--tw-numeric-fraction: ;--tw-ring-inset: ;--tw-ring-offset-width:0px;--tw-ring-offset-color:#fff;--tw-ring-color:rgb(59 130 246 / 0.5);--tw-ring-offset-shadow:0 0 #0000;--tw-ring-shadow:0 0 #0000;--tw-shadow:0 0 #0000;--tw-shadow-colored:0 0 #0000;--tw-blur: ;--tw-brightness: ;--tw-contrast: ;--tw-grayscale: ;--tw-hue-rotate: ;--tw-invert: ;--tw-saturate: ;--tw-sepia: ;--tw-drop-shadow: ;--tw-backdrop-blur: ;--tw-backdrop-brightness: ;--tw-backdrop-contrast: ;--tw-backdrop-grayscale: ;--tw-backdrop-hue-rotate: ;--tw-backdrop-invert: ;--tw-backdrop-opacity: ;--tw-backdrop-saturate: ;--tw-backdrop-sepia: ;--tw-contain-size: ;--tw-contain-layout: ;--tw-contain-paint: ;--tw-contain-style: }::backdrop{--tw-border-spacing-x:0;--tw-border-spacing-y:0;--tw-translate-x:0;--tw-translate-y:0;--tw-rotate:0;--tw-skew-x:0;--tw-skew-y:0;--tw-scale-x:1;--tw-scale-y:1;--tw-pan-x: ;--tw-pan-y: ;--tw-pinch-zoom: ;--tw-scroll-snap-strictness:proximity;--tw-gradient-from-position: ;--tw-gradient-via-position: ;--tw-gradient-to-position: ;--tw-ordinal: ;--tw-slashed-zero: ;--tw-numeric-figure: ;--tw-numeric-spacing: ;--tw-numeric-fraction: ;--tw-ring-inset: ;--tw-ring-offset-width:0px;--tw-ring-offset-color:#fff;--tw-ring-color:rgb(59 130 246 / 0.5);--tw-ring-offset-shadow:0 0 #0000;--tw-ring-shadow:0 0 #0000;--tw-shadow:0 0 #0000;--tw-shadow-colored:0 0 #0000;--tw-blur: ;--tw-brightness: ;--tw-contrast: ;--tw-grayscale: ;--tw-hue-rotate: ;--tw-invert: ;--tw-saturate: ;--tw-sepia: ;--tw-drop-shadow: ;--tw-backdrop-blur: ;--tw-backdrop-brightness: ;--tw-backdrop-contrast: ;--tw-backdrop-grayscale: ;--tw-backdrop-hue-rotate: ;--tw-backdrop-invert: ;--tw-backdrop-opacity: ;--tw-backdrop-saturate: ;--tw-backdrop-sepia: ;--tw-contain-size: ;--tw-contain-layout: ;--tw-contain-paint: ;--tw-contain-style: }/* ! tailwindcss v3.4.17 | MIT License | https://tailwindcss.com */*,::after,::before{box-sizing:border-box;border-width:0;border-style:solid;border-color:#e5e7eb}::after,::before{--tw-content:''}:host,html{line-height:1.5;-webkit-text-size-adjust:100%;-moz-tab-size:4;tab-size:4;font-family:Inter, Noto Sans KR, sans-serif;font-feature-settings:normal;font-variation-settings:normal;-webkit-tap-highlight-color:transparent}body{margin:0;line-height:inherit}hr{height:0;color:inherit;border-top-width:1px}abbr:where([title]){-webkit-text-decoration:underline dotted;text-decoration:underline dotted}h1,h2,h3,h4,h5,h6{font-size:inherit;font-weight:inherit}a{color:inherit;text-decoration:inherit}b,strong{font-weight:bolder}code,kbd,pre,samp{font-family:ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;font-feature-settings:normal;font-variation-settings:normal;font-size:1em}small{font-size:80%}sub,sup{font-size:75%;line-height:0;position:relative;vertical-align:baseline}sub{bottom:-.25em}sup{top:-.5em}table{text-indent:0;border-color:inherit;border-collapse:collapse}button,input,optgroup,select,textarea{font-family:inherit;font-feature-settings:inherit;font-variation-settings:inherit;font-size:100%;font-weight:inherit;line-height:inherit;letter-spacing:inherit;color:inherit;margin:0;padding:0}button,select{text-transform:none}button,input:where([type=button]),input:where([type=reset]),input:where([type=submit]){-webkit-appearance:button;background-color:transparent;background-image:none}:-moz-focusring{outline:auto}:-moz-ui-invalid{box-shadow:none}progress{vertical-align:baseline}::-webkit-inner-spin-button,::-webkit-outer-spin-button{height:auto}[type=search]{-webkit-appearance:textfield;outline-offset:-2px}::-webkit-search-decoration{-webkit-appearance:none}::-webkit-file-upload-button{-webkit-appearance:button;font:inherit}summary{display:list-item}blockquote,dd,dl,figure,h1,h2,h3,h4,h5,h6,hr,p,pre{margin:0}fieldset{margin:0;padding:0}legend{padding:0}menu,ol,ul{list-style:none;margin:0;padding:0}dialog{padding:0}textarea{resize:vertical}input::placeholder,textarea::placeholder{opacity:1;color:#9ca3af}[role=button],button{cursor:pointer}:disabled{cursor:default}audio,canvas,embed,iframe,img,object,svg,video{display:block;vertical-align:middle}img,video{max-width:100%;height:auto}[hidden]:where(:not([hidden=until-found])){display:none}.pointer-events-none{pointer-events:none}.fixed{position:fixed}.absolute{position:absolute}.relative{position:relative}.sticky{position:sticky}.inset-0{inset:0px}.inset-y-0{top:0px;bottom:0px}.-right-1{right:-0.25rem}.-right-10{right:-2.5rem}.-top-1{top:-0.25rem}.-top-10{top:-2.5rem}.bottom-0{bottom:0px}.bottom-1{bottom:0.25rem}.left-0{left:0px}.right-0{right:0px}.right-4{right:1rem}.top-0{top:0px}.top-4{top:1rem}.z-20{z-index:20}.z-30{z-index:30}.z-50{z-index:50}.mx-4{margin-left:1rem;margin-right:1rem}.mx-auto{margin-left:auto;margin-right:auto}.my-3{margin-top:0.75rem;margin-bottom:0.75rem}.mb-1{margin-bottom:0.25rem}.mb-1\.5{margin-bottom:0.375rem}.mb-2{margin-bottom:0.5rem}.mb-3{margin-bottom:0.75rem}.mb-4{margin-bottom:1rem}.mr-1\.5{margin-right:0.375rem}.mr-2{margin-right:0.5rem}.mt-1{margin-top:0.25rem}.mt-2{margin-top:0.5rem}.mt-3{margin-top:0.75rem}.mt-4{margin-top:1rem}.mt-5{margin-top:1.25rem}.block{display:block}.flex{display:flex}.grid{display:grid}.hidden{display:none}.h-1{height:0.25rem}.h-1\.5{height:0.375rem}.h-10{height:2.5rem}.h-16{height:4rem}.h-2{height:0.5rem}.h-2\.5{height:0.625rem}.h-24{height:6rem}.h-3{height:0.75rem}.h-6{height:1.5rem}.h-7{height:1.75rem}.h-8{height:2rem}.h-9{height:2.25rem}.h-\[400px\]{height:400px}.h-full{height:100%}.h-screen{height:100vh}.min-h-screen{min-height:100vh}.w-1{width:0.25rem}.w-1\.5{width:0.375rem}.w-10{width:2.5rem}.w-2\.5{width:0.625rem}.w-24{width:6rem}.w-3{width:0.75rem}.w-5{width:1.25rem}.w-64{width:16rem}.w-7{width:1.75rem}.w-8{width:2rem}.w-9{width:2.25rem}.w-full{width:100%}.max-w-7xl{max-width:80rem}.max-w-md{max-width:28rem}.flex-grow{flex-grow:1}@keyframes pulse{50%{opacity:.5}}.animate-pulse{animation:pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite}.cursor-not-allowed{cursor:not-allowed}.cursor-pointer{cursor:pointer}.grid-cols-1{grid-template-columns:repeat(1, minmax(0, 1fr))}.grid-cols-2{grid-template-columns:repeat(2, minmax(0, 1fr))}.grid-cols-4{grid-template-columns:repeat(4, minmax(0, 1fr))}.grid-cols-7{grid-template-columns:repeat(7, minmax(0, 1fr))}.flex-col{flex-direction:column}.items-start{align-items:flex-start}.items-center{align-items:center}.items-baseline{align-items:baseline}.justify-center{justify-content:center}.justify-between{justify-content:space-between}.gap-1{gap:0.25rem}.gap-1\.5{gap:0.375rem}.gap-2{gap:0.5rem}.gap-3{gap:0.75rem}.gap-4{gap:1rem}.gap-6{gap:1.5rem}.gap-y-2{row-gap:0.5rem}.space-y-1 > :not([hidden]) ~ :not([hidden]){--tw-space-y-reverse:0;margin-top:calc(0.25rem * calc(1 - var(--tw-space-y-reverse)));margin-bottom:calc(0.25rem * var(--tw-space-y-reverse))}.space-y-2 > :not([hidden]) ~ :not([hidden]){--tw-space-y-reverse:0;margin-top:calc(0.5rem * calc(1 - var(--tw-space-y-reverse)));margin-bottom:calc(0.5rem * var(--tw-space-y-reverse))}.space-y-2\.5 > :not([hidden]) ~ :not([hidden]){--tw-space-y-reverse:0;margin-top:calc(0.625rem * calc(1 - var(--tw-space-y-reverse)));margin-bottom:calc(0.625rem * var(--tw-space-y-reverse))}.space-y-3 > :not([hidden]) ~ :not([hidden]){--tw-space-y-reverse:0;margin-top:calc(0.75rem * calc(1 - var(--tw-space-y-reverse)));margin-bottom:calc(0.75rem * var(--tw-space-y-reverse))}.space-y-4 > :not([hidden]) ~ :not([hidden]){--tw-space-y-reverse:0;margin-top:calc(1rem * calc(1 - var(--tw-space-y-reverse)));margin-bottom:calc(1rem * var(--tw-space-y-reverse))}.space-y-6 > :not([hidden]) ~ :not([hidden]){--tw-space-y-reverse:0;margin-top:calc(1.5rem * calc(1 - var(--tw-space-y-reverse)));margin-bottom:calc(1.5rem * var(--tw-space-y-reverse))}.overflow-hidden{overflow:hidden}.overflow-y-auto{overflow-y:auto}.rounded{border-radius:0.25rem}.rounded-2xl{border-radius:1rem}.rounded-full{border-radius:9999px}.rounded-lg{border-radius:0.5rem}.rounded-md{border-radius:0.375rem}.rounded-xl{border-radius:0.75rem}.rounded-r-xl{border-top-right-radius:0.75rem;border-bottom-right-radius:0.75rem}.border{border-width:1px}.border-2{border-width:2px}.border-y{border-top-width:1px;border-bottom-width:1px}.border-b{border-bottom-width:1px}.border-l-4{border-left-width:4px}.border-r{border-right-width:1px}.border-t{border-top-width:1px}.border-blue-400{--tw-border-opacity:1;border-color:rgb(96 165 250 / var(--tw-border-opacity, 1))}.border-blue-500\/20{border-color:rgb(59 130 246 / 0.2)}.border-brand-accent{--tw-border-opacity:1;border-color:rgb(59 130 246 / var(--tw-border-opacity, 1))}.border-brand-accent\/20{border-color:rgb(59 130 246 / 0.2)}.border-brand-accent\/30{border-color:rgb(59 130 246 / 0.3)}.border-brand-border{--tw-border-opacity:1;border-color:rgb(31 41 55 / var(--tw-border-opacity, 1))}.border-brand-border\/60{border-color:rgb(31 41 55 / 0.6)}.border-brand-border\/80{border-color:rgb(31 41 55 / 0.8)}.border-brand-dark{--tw-border-opacity:1;border-color:rgb(11 15 25 / var(--tw-border-opacity, 1))}.border-cyan-400{--tw-border-opacity:1;border-color:rgb(34 211 238 / var(--tw-border-opacity, 1))}.border-emerald-500{--tw-border-opacity:1;border-color:rgb(16 185 129 / var(--tw-border-opacity, 1))}.border-emerald-500\/20{border-color:rgb(16 185 129 / 0.2)}.border-purple-400{--tw-border-opacity:1;border-color:rgb(192 132 252 / var(--tw-border-opacity, 1))}.border-purple-500\/20{border-color:rgb(168 85 247 / 0.2)}.border-red-500{--tw-border-opacity:1;border-color:rgb(239 68 68 / var(--tw-border-opacity, 1))}.border-red-500\/20{border-color:rgb(239 68 68 / 0.2)}.border-slate-950{--tw-border-opacity:1;border-color:rgb(2 6 23 / var(--tw-border-opacity, 1))}.bg-black\/60{background-color:rgb(0 0 0 / 0.6)}.bg-blue-500{--tw-bg-opacity:1;background-color:rgb(59 130 246 / var(--tw-bg-opacity, 1))}.bg-blue-500\/10{background-color:rgb(59 130 246 / 0.1)}.bg-brand-accent{--tw-bg-opacity:1;background-color:rgb(59 130 246 / var(--tw-bg-opacity, 1))}.bg-brand-accent\/15{background-color:rgb(59 130 246 / 0.15)}.bg-brand-accent\/40{background-color:rgb(59 130 246 / 0.4)}.bg-brand-accent\/5{background-color:rgb(59 130 246 / 0.05)}.bg-brand-card{--tw-bg-opacity:1;background-color:rgb(17 24 39 / var(--tw-bg-opacity, 1))}.bg-brand-card\/30{background-color:rgb(17 24 39 / 0.3)}.bg-brand-card\/50{background-color:rgb(17 24 39 / 0.5)}.bg-brand-neonBlue{--tw-bg-opacity:1;background-color:rgb(0 210 255 / var(--tw-bg-opacity, 1))}.bg-brand-neonGreen{--tw-bg-opacity:1;background-color:rgb(16 185 129 / var(--tw-bg-opacity, 1))}.bg-cyan-400{--tw-bg-opacity:1;background-color:rgb(34 211 238 / var(--tw-bg-opacity, 1))}.bg-emerald-500{--tw-bg-opacity:1;background-color:rgb(16 185 129 / var(--tw-bg-opacity, 1))}.bg-emerald-500\/10{background-color:rgb(16 185 129 / 0.1)}.bg-purple-500{--tw-bg-opacity:1;background-color:rgb(168 85 247 / var(--tw-bg-opacity, 1))}.bg-purple-500\/10{background-color:rgb(168 85 247 / 0.1)}.bg-red-500{--tw-bg-opacity:1;background-color:rgb(239 68 68 / var(--tw-bg-opacity, 1))}.bg-red-500\/10{background-color:rgb(239 68 68 / 0.1)}.bg-slate-800{--tw-bg-opacity:1;background-color:rgb(30 41 59 / var(--tw-bg-opacity, 1))}.bg-slate-900{--tw-bg-opacity:1;background-color:rgb(15 23 42 / var(--tw-bg-opacity, 1))}.bg-slate-900\/40{background-color:rgb(15 23 42 / 0.4)}.bg-slate-950{--tw-bg-opacity:1;background-color:rgb(2 6 23 / var(--tw-bg-opacity, 1))}.bg-slate-950\/20{background-color:rgb(2 6 23 / 0.2)}.bg-slate-950\/40{background-color:rgb(2 6 23 / 0.4)}.bg-yellow-500{--tw-bg-opacity:1;background-color:rgb(234 179 8 / var(--tw-bg-opacity, 1))}.bg-gradient-to-r{background-image:linear-gradient(to right, var(--tw-gradient-stops))}.bg-gradient-to-tr{background-image:linear-gradient(to top right, var(--tw-gradient-stops))}.from-brand-accent{--tw-gradient-from:#3b82f6 var(--tw-gradient-from-position);--tw-gradient-to:rgb(59 130 246 / 0) var(--tw-gradient-to-position);--tw-gradient-stops:var(--tw-gradient-from), var(--tw-gradient-to)}.from-cyan-500{--tw-gradient-from:#06b6d4 var(--tw-gradient-from-position);--tw-gradient-to:rgb(6 182 212 / 0) var(--tw-gradient-to-position);--tw-gradient-stops:var(--tw-gradient-from), var(--tw-gradient-to)}.from-emerald-500{--tw-gradient-from:#10b981 var(--tw-gradient-from-position);--tw-gradient-to:rgb(16 185 129 / 0) var(--tw-gradient-to-position);--tw-gradient-stops:var(--tw-gradient-from), var(--tw-gradient-to)}.to-brand-accent{--tw-gradient-to:#3b82f6 var(--tw-gradient-to-position)}.to-cyan-400{--tw-gradient-to:#22d3ee var(--tw-gradient-to-position)}.to-teal-500{--tw-gradient-to:#14b8a6 var(--tw-gradient-to-position)}.object-cover{object-fit:cover}.p-1{padding:0.25rem}.p-2{padding:0.5rem}.p-2\.5{padding:0.625rem}.p-3{padding:0.75rem}.p-4{padding:1rem}.p-6{padding:1.5rem}.p-8{padding:2rem}.px-1\.5{padding-left:0.375rem;padding-right:0.375rem}.px-2{padding-left:0.5rem;padding-right:0.5rem}.px-2\.5{padding-left:0.625rem;padding-right:0.625rem}.px-3{padding-left:0.75rem;padding-right:0.75rem}.px-4{padding-left:1rem;padding-right:1rem}.px-8{padding-left:2rem;padding-right:2rem}.py-0\.5{padding-top:0.125rem;padding-bottom:0.125rem}.py-1{padding-top:0.25rem;padding-bottom:0.25rem}.py-1\.5{padding-top:0.375rem;padding-bottom:0.375rem}.py-2{padding-top:0.5rem;padding-bottom:0.5rem}.py-2\.5{padding-top:0.625rem;padding-bottom:0.625rem}.py-4{padding-top:1rem;padding-bottom:1rem}.pl-3{padding-left:0.75rem}.pl-8{padding-left:2rem}.pl-9{padding-left:2.25rem}.pr-2{padding-right:0.5rem}.pr-3{padding-right:0.75rem}.pt-3{padding-top:0.75rem}.pt-4{padding-top:1rem}.text-center{text-align:center}.text-right{text-align:right}.font-mono{font-family:ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace}.text-3xl{font-size:1.875rem;line-height:2.25rem}.text-5xl{font-size:3rem;line-height:1}.text-\[10px\]{font-size:10px}.text-\[11px\]{font-size:11px}.text-base{font-size:1rem;line-height:1.5rem}.text-lg{font-size:1.125rem;line-height:1.75rem}.text-sm{font-size:0.875rem;line-height:1.25rem}.text-xl{font-size:1.25rem;line-height:1.75rem}.text-xs{font-size:0.75rem;line-height:1rem}.font-black{font-weight:900}.font-bold{font-weight:700}.font-extrabold{font-weight:800}.font-medium{font-weight:500}.font-semibold{font-weight:600}.uppercase{text-transform:uppercase}.tracking-tighter{letter-spacing:-0.05em}.tracking-wider{letter-spacing:0.05em}.tracking-widest{letter-spacing:0.1em}.text-blue-400{--tw-text-opacity:1;color:rgb(96 165 250 / var(--tw-text-opacity, 1))}.text-brand-neonBlue{--tw-text-opacity:1;color:rgb(0 210 255 / var(--tw-text-opacity, 1))}.text-cyan-400{--tw-text-opacity:1;color:rgb(34 211 238 / var(--tw-text-opacity, 1))}.text-emerald-400{--tw-text-opacity:1;color:rgb(52 211 153 / var(--tw-text-opacity, 1))}.text-emerald-500{--tw-text-opacity:1;color:rgb(16 185 129 / var(--tw-text-opacity, 1))}.text-gray-100{--tw-text-opacity:1;color:rgb(243 244 246 / var(--tw-text-opacity, 1))}.text-gray-200{--tw-text-opacity:1;color:rgb(229 231 235 / var(--tw-text-opacity, 1))}.text-gray-300{--tw-text-opacity:1;color:rgb(209 213 219 / var(--tw-text-opacity, 1))}.text-gray-400{--tw-text-opacity:1;color:rgb(156 163 175 / var(--tw-text-opacity, 1))}.text-gray-500{--tw-text-opacity:1;color:rgb(107 114 128 / var(--tw-text-opacity, 1))}.text-gray-700{--tw-text-opacity:1;color:rgb(55 65 81 / var(--tw-text-opacity, 1))}.text-orange-400{--tw-text-opacity:1;color:rgb(251 146 60 / var(--tw-text-opacity, 1))}.text-purple-400{--tw-text-opacity:1;color:rgb(192 132 252 / var(--tw-text-opacity, 1))}.text-red-400{--tw-text-opacity:1;color:rgb(248 113 113 / var(--tw-text-opacity, 1))}.text-white{--tw-text-opacity:1;color:rgb(255 255 255 / var(--tw-text-opacity, 1))}.opacity-80{opacity:0.8}.shadow-2xl{--tw-shadow:0 25px 50px -12px rgb(0 0 0 / 0.25);--tw-shadow-colored:0 25px 50px -12px var(--tw-shadow-color);box-shadow:var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow)}.shadow-lg{--tw-shadow:0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);--tw-shadow-colored:0 10px 15px -3px var(--tw-shadow-color), 0 4px 6px -4px var(--tw-shadow-color);box-shadow:var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow)}.shadow-xl{--tw-shadow:0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);--tw-shadow-colored:0 20px 25px -5px var(--tw-shadow-color), 0 8px 10px -6px var(--tw-shadow-color);box-shadow:var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow)}.shadow-brand-accent\/20{--tw-shadow-color:rgb(59 130 246 / 0.2);--tw-shadow:var(--tw-shadow-colored)}.shadow-emerald-500\/10{--tw-shadow-color:rgb(16 185 129 / 0.1);--tw-shadow:var(--tw-shadow-colored)}.blur-2xl{--tw-blur:blur(40px);filter:var(--tw-blur) var(--tw-brightness) var(--tw-contrast) var(--tw-grayscale) var(--tw-hue-rotate) var(--tw-invert) var(--tw-saturate) var(--tw-sepia) var(--tw-drop-shadow)}.backdrop-blur-md{--tw-backdrop-blur:blur(12px);-webkit-backdrop-filter:var(--tw-backdrop-blur) var(--tw-backdrop-brightness) var(--tw-backdrop-contrast) var(--tw-backdrop-grayscale) var(--tw-backdrop-hue-rotate) var(--tw-backdrop-invert) var(--tw-backdrop-opacity) var(--tw-backdrop-saturate) var(--tw-backdrop-sepia);backdrop-filter:var(--tw-backdrop-blur) var(--tw-backdrop-brightness) var(--tw-backdrop-contrast) var(--tw-backdrop-grayscale) var(--tw-backdrop-hue-rotate) var(--tw-backdrop-invert) var(--tw-backdrop-opacity) var(--tw-backdrop-saturate) var(--tw-backdrop-sepia)}.backdrop-blur-sm{--tw-backdrop-blur:blur(4px);-webkit-backdrop-filter:var(--tw-backdrop-blur) var(--tw-backdrop-brightness) var(--tw-backdrop-contrast) var(--tw-backdrop-grayscale) var(--tw-backdrop-hue-rotate) var(--tw-backdrop-invert) var(--tw-backdrop-opacity) var(--tw-backdrop-saturate) var(--tw-backdrop-sepia);backdrop-filter:var(--tw-backdrop-blur) var(--tw-backdrop-brightness) var(--tw-backdrop-contrast) var(--tw-backdrop-grayscale) var(--tw-backdrop-hue-rotate) var(--tw-backdrop-invert) var(--tw-backdrop-opacity) var(--tw-backdrop-saturate) var(--tw-backdrop-sepia)}.transition{transition-property:color, background-color, border-color, fill, stroke, opacity, box-shadow, transform, filter, -webkit-text-decoration-color, -webkit-backdrop-filter;transition-property:color, background-color, border-color, text-decoration-color, fill, stroke, opacity, box-shadow, transform, filter, backdrop-filter;transition-property:color, background-color, border-color, text-decoration-color, fill, stroke, opacity, box-shadow, transform, filter, backdrop-filter, -webkit-text-decoration-color, -webkit-backdrop-filter;transition-timing-function:cubic-bezier(0.4, 0, 0.2, 1);transition-duration:150ms}.transition-all{transition-property:all;transition-timing-function:cubic-bezier(0.4, 0, 0.2, 1);transition-duration:150ms}.transition-transform{transition-property:transform;transition-timing-function:cubic-bezier(0.4, 0, 0.2, 1);transition-duration:150ms}.duration-200{transition-duration:200ms}.duration-300{transition-duration:300ms}.hover\:bg-blue-600:hover{--tw-bg-opacity:1;background-color:rgb(37 99 235 / var(--tw-bg-opacity, 1))}.hover\:bg-brand-card:hover{--tw-bg-opacity:1;background-color:rgb(17 24 39 / var(--tw-bg-opacity, 1))}.hover\:bg-slate-800:hover{--tw-bg-opacity:1;background-color:rgb(30 41 59 / var(--tw-bg-opacity, 1))}.hover\:bg-slate-900:hover{--tw-bg-opacity:1;background-color:rgb(15 23 42 / var(--tw-bg-opacity, 1))}.hover\:text-white:hover{--tw-text-opacity:1;color:rgb(255 255 255 / var(--tw-text-opacity, 1))}.hover\:underline:hover{-webkit-text-decoration-line:underline;text-decoration-line:underline}.hover\:brightness-110:hover{--tw-brightness:brightness(1.1);filter:var(--tw-blur) var(--tw-brightness) var(--tw-contrast) var(--tw-grayscale) var(--tw-hue-rotate) var(--tw-invert) var(--tw-saturate) var(--tw-sepia) var(--tw-drop-shadow)}.focus\:border-brand-accent:focus{--tw-border-opacity:1;border-color:rgb(59 130 246 / var(--tw-border-opacity, 1))}.focus\:outline-none:focus{outline:2px solid transparent;outline-offset:2px}.group:hover .group-hover\:text-cyan-400{--tw-text-opacity:1;color:rgb(34 211 238 / var(--tw-text-opacity, 1))}@media (min-width: 768px){.md\:grid-cols-3{grid-template-columns:repeat(3, minmax(0, 1fr))}.md\:flex-row{flex-direction:row}.md\:items-center{align-items:center}}@media (min-width: 1024px){.lg\:col-span-4{grid-column:span 4 / span 4}.lg\:col-span-5{grid-column:span 5 / span 5}.lg\:col-span-7{grid-column:span 7 / span 7}.lg\:col-span-8{grid-column:span 8 / span 8}.lg\:flex{display:flex}.lg\:grid-cols-12{grid-template-columns:repeat(12, minmax(0, 1fr))}}</style></head>
<body class="min-height-screen flex">

    <!-- 1. LEFT SIDEBAR (사이드바) -->
    <aside class="w-64 bg-slate-950 border-r border-brand-border flex flex-col justify-between h-screen sticky top-0 z-30">
        <div>
            <!-- 로고 영역 -->
            <div class="p-6 border-b border-brand-border flex items-center justify-between">
                <div class="flex items-center gap-3">
                    <div class="bg-gradient-to-tr from-brand-accent to-cyan-400 p-2 rounded-lg text-white">
                        <i class="fa-solid fa-code-merge text-xl"></i>
                    </div>
                    <div>
                        <span class="font-extrabold text-xl text-white tracking-wider">DevSync</span>
                        <span class="text-xs block text-cyan-400 font-semibold tracking-widest uppercase">IT Groupware</span>
                    </div>
                </div>
            </div>

            <!-- 사용자 간이 프로필 -->
            <div class="p-4 mx-4 my-3 bg-brand-card/50 rounded-xl border border-brand-border/60 flex items-center gap-3">
                <div class="relative">
                    <img src="./DevSync - IT 개발사 스마트 대시보드_files/photo-1534528741775-53994a69daeb" alt="Profile" class="w-10 h-10 rounded-full border border-cyan-400 object-cover">
                    <span class="absolute bottom-0 right-0 w-3 h-3 bg-emerald-500 border-2 border-slate-950 rounded-full"></span>
                </div>
                <div>
                    <h4 class="font-bold text-sm text-gray-100">이도현 과장</h4>
                    <span class="text-xs text-gray-400">웹 프론트엔드 파트</span>
                </div>
            </div>

            <!-- 메인 네비게이션 메뉴 (Interactive accordion) -->
            <nav class="px-4 space-y-1">
                <!-- 1. 근무 관리 -->
                <div>
                    <button onclick="toggleSubmenu(&#39;sub-work&#39;)" class="w-full flex items-center justify-between p-3 text-gray-300 hover:text-white hover:bg-brand-card rounded-lg transition duration-200 group">
                        <div class="flex items-center gap-3">
                            <i class="fa-solid fa-clock-rotate-left text-gray-400 group-hover:text-cyan-400 w-5"></i>
                            <span class="font-medium text-sm">근무 관리</span>
                        </div>
                        <i id="arrow-sub-work" class="fa-solid text-xs transition-transform fa-chevron-up text-cyan-400"></i>
                    </button>
                    <div id="sub-work" class="pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400 transition-all duration-300">
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">출퇴근 및 타임카드</a>
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">유연근무 현황</a>
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">외근/파견/상주 신청</a>
                    </div>
                </div>

                <!-- 2. 휴가 관리 -->
                <div>
                    <button onclick="toggleSubmenu(&#39;sub-leave&#39;)" class="w-full flex items-center justify-between p-3 text-gray-300 hover:text-white hover:bg-brand-card rounded-lg transition duration-200 group">
                        <div class="flex items-center gap-3">
                            <i class="fa-solid fa-umbrella text-gray-400 group-hover:text-cyan-400 w-5"></i>
                            <span class="font-medium text-sm">휴가 관리</span>
                        </div>
                        <i id="arrow-sub-leave" class="fa-solid text-xs transition-transform fa-chevron-up text-cyan-400"></i>
                    </button>
                    <div id="sub-leave" class="pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400">
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">휴가 신청서 작성</a>
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">잔여 연차 현황</a>
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">대체/보상 휴가 적립</a>
                    </div>
                </div>

                <!-- 3. 일정/공유 (Active) -->
                <div>
                    <button onclick="toggleSubmenu(&#39;sub-schedule&#39;)" class="w-full flex items-center justify-between p-3 text-white bg-brand-card rounded-lg transition duration-200 group">
                        <div class="flex items-center gap-3">
                            <i class="fa-solid fa-calendar-check text-cyan-400 w-5"></i>
                            <span class="font-medium text-sm">일정/공유</span>
                        </div>
                        <i id="arrow-sub-schedule" class="fa-solid text-xs transition-transform fa-chevron-down text-gray-500"></i>
                    </button>
                    <div id="sub-schedule" class="block pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400 hidden">
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 text-cyan-400 font-semibold rounded-md bg-slate-900/40">종합 일정 캘린더</a>
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">회의실/자원 예약</a>
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">공용 테스트폰 대여</a>
                    </div>
                </div>

                <!-- 4. 프로젝트/사업 -->
                <div>
                    <button onclick="toggleSubmenu(&#39;sub-project&#39;)" class="w-full flex items-center justify-between p-3 text-gray-300 hover:text-white hover:bg-brand-card rounded-lg transition duration-200 group">
                        <div class="flex items-center gap-3">
                            <i class="fa-solid fa-cubes-stacked text-gray-400 group-hover:text-cyan-400 w-5"></i>
                            <span class="font-medium text-sm">프로젝트/사업</span>
                        </div>
                        <i id="arrow-sub-project" class="fa-solid text-xs transition-transform fa-chevron-up text-cyan-400"></i>
                    </button>
                    <div id="sub-project" class="pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400">
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">전사 사업 현황판</a>
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">Jira 스프린트 싱크</a>
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">투입 공수(M/M) 정산</a>
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">프로젝트 산출물 아카이브</a>
                    </div>
                </div>

                <!-- 5. 인프라/총무 -->
                <div>
                    <button onclick="toggleSubmenu(&#39;sub-infra&#39;)" class="w-full flex items-center justify-between p-3 text-gray-300 hover:text-white hover:bg-brand-card rounded-lg transition duration-200 group">
                        <div class="flex items-center gap-3">
                            <i class="fa-solid fa-laptop-code text-gray-400 group-hover:text-cyan-400 w-5"></i>
                            <span class="font-medium text-sm">인프라/총무</span>
                        </div>
                        <i id="arrow-sub-infra" class="fa-solid fa-chevron-down text-xs text-gray-500 transition-transform"></i>
                    </button>
                    <div id="sub-infra" class="hidden pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400">
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">장비/기기 할당 대장</a>
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">SW 라이선스 신청</a>
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">비대면 증명서 발급</a>
                    </div>
                </div>

                <!-- 6. 비용/회계 -->
                <div>
                    <button onclick="toggleSubmenu(&#39;sub-finance&#39;)" class="w-full flex items-center justify-between p-3 text-gray-300 hover:text-white hover:bg-brand-card rounded-lg transition duration-200 group">
                        <div class="flex items-center gap-3">
                            <i class="fa-solid fa-file-invoice-dollar text-gray-400 group-hover:text-cyan-400 w-5"></i>
                            <span class="font-medium text-sm">비용/회계</span>
                        </div>
                        <i id="arrow-sub-finance" class="fa-solid fa-chevron-down text-xs text-gray-500 transition-transform"></i>
                    </button>
                    <div id="sub-finance" class="hidden pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400">
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">지출 경비 청구(OCR)</a>
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">급여 명세서 조회</a>
                        <a href="file:///C:/Users/User/Documents/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1%20%EB%B0%9B%EC%9D%80%20%ED%8C%8C%EC%9D%BC/it_mockup.html#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">프로젝트별 손익 리포트</a>
                    </div>
                </div>
            </nav>
        </div>

        <!-- 하단 푸터 / 세팅 -->
        <div class="p-4 border-t border-brand-border flex items-center justify-between text-xs text-gray-500">
            <span>Server: <span class="text-emerald-500 font-bold">Stable</span></span>
            <button class="hover:text-white"><i class="fa-solid fa-gear text-sm"></i></button>
        </div>
    </aside>

    <!-- 2. MAIN LAYOUT (메인 대시보드 영역) -->
    <div class="flex-grow flex flex-col min-h-screen">
        
        <!-- TOP NAVIGATION BAR (상단 글로벌 메뉴바) -->
        <header class="h-16 border-b border-brand-border bg-brand-card/30 backdrop-blur-md flex items-center justify-between px-8 sticky top-0 z-20">
            <!-- 브레드크럼 -->
            <div class="flex items-center gap-2 text-sm text-gray-400">
                <span>IT 개발사 스마트 포털</span>
                <i class="fa-solid fa-angle-right text-xs"></i>
                <span class="text-gray-100 font-semibold">대시보드 홈</span>
            </div>

            <!-- 상단 검색창 및 연동 상태 -->
            <div class="flex items-center gap-6">
                <!-- 전사 연동 서비스 모니터링 -->
                <div class="hidden lg:flex items-center gap-3 text-xs bg-slate-900 border border-brand-border px-3 py-1.5 rounded-full">
                    <span class="flex items-center gap-1.5 text-gray-400">
                        <i class="fa-brands fa-github text-gray-100"></i> Github: <span class="text-emerald-400 font-semibold">Connected</span>
                    </span>
                    <span class="text-gray-700">|</span>
                    <span class="flex items-center gap-1.5 text-gray-400">
                        <i class="fa-brands fa-jira text-blue-400"></i> Jira: <span class="text-emerald-400 font-semibold">Sync</span>
                    </span>
                    <span class="text-gray-700">|</span>
                    <span class="flex items-center gap-1.5 text-gray-400">
                        <i class="fa-brands fa-slack text-orange-400"></i> Slack: <span class="text-emerald-400 font-semibold">Active</span>
                    </span>
                </div>

                <!-- 검색창 -->
                <div class="relative w-64">
                    <span class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                        <i class="fa-solid fa-magnifying-glass text-gray-500 text-xs"></i>
                    </span>
                    <input type="text" class="w-full bg-slate-900 border border-brand-border text-xs text-gray-100 rounded-lg pl-9 pr-3 py-2 focus:outline-none focus:border-brand-accent transition" placeholder="프로젝트, 마일스톤, 문서 통합 검색">
                </div>

                <!-- 알림창 (Badge포함) -->
                <div class="relative cursor-pointer hover:text-white text-gray-400">
                    <i class="fa-solid fa-bell text-lg"></i>
                    <span class="absolute -top-1 -right-1 w-2.5 h-2.5 bg-red-500 rounded-full border border-brand-dark animate-pulse"></span>
                </div>
            </div>
        </header>

        <!-- DASHBOARD CONTAINER (콘텐츠 스크롤 구역) -->
        <main class="flex-grow p-8 space-y-6 max-w-7xl mx-auto w-full">
            
            <!-- ROW 1: QUICK ACTIONS & STATUS (상단 근태/휴가 요약 그리드) -->
            <section class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <!-- 위젯 A: 스마트 근태 체크 (출퇴근 타임클락 - INTERACTIVE!) -->
                <div class="bg-brand-card p-6 rounded-2xl border border-brand-border flex flex-col justify-between shadow-xl relative overflow-hidden">
                    <div class="absolute -right-10 -top-10 w-24 h-24 bg-brand-accent/5 rounded-full blur-2xl"></div>
                    <div>
                        <div class="flex items-center justify-between mb-4">
                            <h3 class="font-bold text-gray-200 text-base">근무 상태 컨트롤러</h3>
                            <span id="work-location-badge" class="px-2.5 py-0.5 bg-brand-accent/15 border border-brand-accent/30 text-brand-neonBlue text-xs rounded-full font-bold">본사 근무</span>
                        </div>
                        
                        <!-- 근무지 토글 칩스 -->
                        <div class="grid grid-cols-4 gap-1.5 mb-4">
                            <button onclick="setWorkLocation(&#39;본사&#39;)" id="loc-본사" class="py-1 text-xs rounded-lg font-semibold bg-brand-accent text-white border border-brand-accent transition">본사</button>
                            <button onclick="setWorkLocation(&#39;재택&#39;)" id="loc-재택" class="py-1 text-xs rounded-lg font-semibold bg-slate-900 text-gray-400 border border-brand-border hover:text-white transition">재택</button>
                            <button onclick="setWorkLocation(&#39;외근&#39;)" id="loc-외근" class="py-1 text-xs rounded-lg font-semibold bg-slate-900 text-gray-400 border border-brand-border hover:text-white transition">외근</button>
                            <button onclick="setWorkLocation(&#39;상주&#39;)" id="loc-상주" class="py-1 text-xs rounded-lg font-semibold bg-slate-900 text-gray-400 border border-brand-border hover:text-white transition">상주</button>
                        </div>

                        <!-- 실시간 근무 타이머 -->
                        <div class="text-center py-2">
                            <span id="timer-display" class="text-3xl font-extrabold text-white tracking-widest font-mono">00 : 00 : 00</span>
                            <p class="text-xs text-gray-400 mt-1">오늘 총 기록된 근무 시간</p>
                        </div>
                    </div>

                    <!-- 출퇴근 작동 버튼 -->
                    <div class="grid grid-cols-2 gap-3 mt-4">
                        <button id="btn-checkin" onclick="triggerCheckIn()" class="w-full py-2.5 bg-gradient-to-r from-emerald-500 to-teal-500 hover:brightness-110 text-white rounded-xl text-sm font-bold shadow-lg shadow-emerald-500/10 transition flex items-center justify-center gap-2">
                            <i class="fa-solid fa-arrow-right-to-bracket"></i> 출근하기
                        </button>
                        <button id="btn-checkout" onclick="triggerCheckOut()" class="w-full py-2.5 bg-slate-800 text-gray-500 border border-brand-border rounded-xl text-sm font-bold cursor-not-allowed transition flex items-center justify-center gap-2" disabled="">
                            <i class="fa-solid fa-arrow-right-from-bracket"></i> 퇴근하기
                        </button>
                    </div>
                </div>

                <!-- 위젯 B: 나의 휴가 요약 -->
                <div class="bg-brand-card p-6 rounded-2xl border border-brand-border flex flex-col justify-between shadow-xl">
                    <div>
                        <div class="flex items-center justify-between mb-4">
                            <h3 class="font-bold text-gray-200 text-base">연차 소진 및 잔여</h3>
                            <button class="text-xs text-cyan-400 font-bold hover:underline">휴가계획 수립 <i class="fa-solid fa-arrow-right"></i></button>
                        </div>
                        <div class="flex items-baseline gap-2 justify-center py-4">
                            <span class="text-5xl font-black text-white font-mono tracking-tighter">11.5</span>
                            <span class="text-lg text-gray-400">/ 15 일</span>
                        </div>
                        <!-- 커스텀 프로그레스바 -->
                        <div class="w-full bg-slate-900 h-2.5 rounded-full overflow-hidden border border-brand-border">
                            <div class="bg-gradient-to-r from-cyan-500 to-brand-accent h-full rounded-full" style="width: 76.6%;"></div>
                        </div>
                        <div class="flex justify-between text-xs text-gray-400 mt-2">
                            <span>사용한 연차: 3.5일</span>
                            <span>남은 연차: 11.5일</span>
                        </div>
                    </div>
                    <!-- 단축 링크 -->
                    <button class="w-full mt-4 py-2.5 bg-slate-900 hover:bg-slate-800 border border-brand-border text-gray-200 rounded-xl text-xs font-semibold transition flex items-center justify-center gap-2">
                        <i class="fa-solid fa-file-signature text-cyan-400"></i> 전자 휴가 결재 기안하기
                    </button>
                </div>

                <!-- 위젯 C: 내 Jira 스프린트 / PR 현황 -->
                <div class="bg-brand-card p-6 rounded-2xl border border-brand-border flex flex-col justify-between shadow-xl">
                    <div>
                        <div class="flex items-center justify-between mb-3">
                            <h3 class="font-bold text-gray-200 text-base">스프린트 개발 공수 (Jira)</h3>
                            <span class="px-2 py-0.5 bg-blue-500/10 border border-blue-500/20 text-blue-400 text-[10px] rounded font-bold uppercase">Sprint 24</span>
                        </div>
                        <div class="space-y-3 py-1">
                            <div>
                                <div class="flex justify-between text-xs mb-1">
                                    <span class="text-gray-300 font-medium">#102 쇼핑몰 결제 연동 API</span>
                                    <span class="text-cyan-400 font-semibold">82%</span>
                                </div>
                                <div class="w-full bg-slate-900 h-2 rounded-full overflow-hidden">
                                    <div class="bg-brand-neonBlue h-full rounded-full" style="width: 82%;"></div>
                                </div>
                            </div>
                            <div>
                                <div class="flex justify-between text-xs mb-1">
                                    <span class="text-gray-300 font-medium">#105 모바일 결제 화면 UI 고도화</span>
                                    <span class="text-emerald-400 font-semibold">100% (Done)</span>
                                </div>
                                <div class="w-full bg-slate-900 h-2 rounded-full overflow-hidden">
                                    <div class="bg-emerald-500 h-full rounded-full" style="width: 100%;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 깃허브 Pull Request 링크 연동 인터페이스 -->
                    <div class="border-t border-brand-border/60 pt-3 mt-3 flex items-center justify-between text-xs">
                        <span class="text-gray-400"><i class="fa-brands fa-github text-gray-300 mr-1.5"></i> PR 대기 중인 코드</span>
                        <a href="#" class="text-brand-neonBlue hover:underline font-semibold flex items-center gap-1">2건 검토하기 <i class="fa-solid fa-chevron-right text-[10px]"></i></a>
                    </div>
                </div>
            </section>

            <!-- ROW 2: SIGNATURE SCHEDULE WIDGET (시그니처 스마트 일정 위젯 - 2단분리) -->
            <section class="bg-brand-card rounded-2xl border border-brand-border shadow-xl overflow-hidden">
                <!-- 위젯 타이틀 및 대형 필터 컨트롤 -->
                <div class="p-6 border-b border-brand-border bg-slate-950/40 flex flex-col md:flex-row md:items-center justify-between gap-4">
                    <div class="flex items-center gap-3">
                        <div class="w-2.5 h-6 bg-brand-accent rounded-full"></div>
                        <div>
                            <h2 class="text-lg font-bold text-gray-100">스마트 일정 위젯 (스케줄러)</h2>
                            <p class="text-xs text-gray-400">출퇴근 근무기록, 프로젝트 마일스톤, 팀원 상태의 지능형 캘린더 통합</p>
                        </div>
                    </div>

                    <!-- 퀵 캘린더 탭 (INTERACTIVE!) -->
                    <div class="flex p-1 bg-slate-900 border border-brand-border rounded-xl">
                        <button id="tab-all" onclick="filterEvents(&#39;all&#39;)" class="px-4 py-1.5 text-xs font-semibold rounded-lg text-white bg-brand-accent transition">전체 일정</button>
                        <button id="tab-my" onclick="filterEvents(&#39;my&#39;)" class="px-4 py-1.5 text-xs font-semibold rounded-lg text-gray-400 hover:text-white transition">내 일정</button>
                        <button id="tab-project" onclick="filterEvents(&#39;project&#39;)" class="px-4 py-1.5 text-xs font-semibold rounded-lg text-gray-400 hover:text-white transition">프로젝트</button>
                        <button id="tab-team" onclick="filterEvents(&#39;team&#39;)" class="px-4 py-1.5 text-xs font-semibold rounded-lg text-gray-400 hover:text-white transition">팀 휴가/재택</button>
                    </div>
                </div>

                <!-- 캘린더 2컬럼 레이아웃 -->
                <div class="grid grid-cols-1 lg:grid-cols-12">
                    <!-- 좌측 1/3 컬럼: Mini Calendar -->
                    <div class="lg:col-span-4 p-6 border-r border-brand-border bg-slate-950/20">
                        <div class="flex items-center justify-between mb-4">
                            <span class="text-sm font-extrabold text-gray-200">2026년 5월</span>
                            <div class="flex gap-1.5">
                                <button class="w-7 h-7 flex items-center justify-center rounded-lg bg-slate-900 hover:bg-slate-800 border border-brand-border text-gray-400 hover:text-white transition"><i class="fa-solid fa-angle-left text-xs"></i></button>
                                <button class="w-7 h-7 flex items-center justify-center rounded-lg bg-slate-900 hover:bg-slate-800 border border-brand-border text-gray-400 hover:text-white transition"><i class="fa-solid fa-angle-right text-xs"></i></button>
                            </div>
                        </div>

                        <!-- 캘린더 일자 그리드 (INTERACTIVE!) -->
                        <div class="grid grid-cols-7 gap-y-2 text-center text-xs mb-4">
                            <!-- 요일 라벨 -->
                            <span class="text-red-400 font-semibold opacity-80">일</span>
                            <span class="text-gray-400 font-semibold">월</span>
                            <span class="text-gray-400 font-semibold">화</span>
                            <span class="text-gray-400 font-semibold">수</span>
                            <span class="text-gray-400 font-semibold">목</span>
                            <span class="text-gray-400 font-semibold">금</span>
                            <span class="text-gray-400 font-semibold">토</span>

                            <!-- 빈 셀 (이전달) -->
                            <span class="text-gray-700 py-2">26</span>
                            <span class="text-gray-700 py-2">27</span>
                            <span class="text-gray-700 py-2">28</span>
                            <span class="text-gray-700 py-2">29</span>
                            <span class="text-gray-700 py-2">30</span>
                            <span class="text-gray-500 py-2">1</span>
                            <span class="text-gray-500 py-2">2</span>

                            <!-- 이번달 일자 및 일정 도트(Indicator) 표시 -->
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">3</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">4</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">5</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">6</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">7</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">8</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">9</span>

                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">10</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">11</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">12</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">13</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">14</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">15</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">16</span>

                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">17</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">18</span>
                            <!-- 일정 있는 날(도트) -->
                            <span onclick="selectCalendarDate(19)" class="text-gray-300 py-2 hover:bg-slate-900 rounded-lg cursor-pointer relative flex flex-col items-center justify-center">19<span class="w-1 h-1 bg-purple-500 rounded-full absolute bottom-1"></span></span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">20</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">21</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">22</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">23</span>

                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">24</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">25</span>
                            <!-- 오늘 날짜 및 활성화(Selected) 처리 -->
                            <span id="cal-date-26" onclick="selectCalendarDate(26)" class="text-white py-2 bg-brand-accent/40 border border-brand-accent rounded-lg cursor-pointer relative flex flex-col items-center justify-center font-bold">26<span class="w-1 h-1 bg-cyan-400 rounded-full absolute bottom-1"></span></span>
                            <!-- 다른 일정 있는 날짜들 -->
                            <span id="cal-date-27" onclick="selectCalendarDate(27)" class="text-gray-300 py-2 hover:bg-slate-900 rounded-lg cursor-pointer relative flex flex-col items-center justify-center">27<span class="w-1.5 h-1.5 bg-brand-neonGreen rounded-full absolute bottom-1"></span></span>
                            <span id="cal-date-28" onclick="selectCalendarDate(28)" class="text-gray-300 py-2 hover:bg-slate-900 rounded-lg cursor-pointer relative flex flex-col items-center justify-center">28<span class="w-1.5 h-1.5 bg-yellow-500 rounded-full absolute bottom-1"></span></span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">29</span>
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">30</span>
                            
                            <span class="text-gray-400 py-2 hover:bg-slate-900 rounded-lg cursor-pointer">31</span>
                            <span class="text-gray-700 py-2">1</span>
                            <span class="text-gray-700 py-2">2</span>
                            <span class="text-gray-700 py-2">3</span>
                            <span class="text-gray-700 py-2">4</span>
                            <span class="text-gray-700 py-2">5</span>
                            <span class="text-gray-700 py-2">6</span>
                        </div>

                        <!-- 캘린더 범례 요약 -->
                        <div class="border-t border-brand-border/60 pt-4 space-y-2">
                            <span class="text-xs font-bold text-gray-400 block mb-1">일정 구분별 색상 피드</span>
                            <div class="grid grid-cols-2 gap-2 text-[10px] text-gray-400 font-semibold">
                                <span class="flex items-center gap-2"><span class="w-2.5 h-2.5 bg-red-500 rounded-full"></span>배포 및 핫픽스</span>
                                <span class="flex items-center gap-2"><span class="w-2.5 h-2.5 bg-purple-500 rounded-full"></span>클라이언트 미팅</span>
                                <span class="flex items-center gap-2"><span class="w-2.5 h-2.5 bg-brand-accent rounded-full"></span>스프린트 회의</span>
                                <span class="flex items-center gap-2"><span class="w-2.5 h-2.5 bg-brand-neonGreen rounded-full"></span>대체/팀원휴가</span>
                            </div>
                        </div>
                    </div>

                    <!-- 우측 2/3 컬럼: Timeline & List View (INTERACTIVE EVENT LIST) -->
                    <div class="lg:col-span-8 p-6 flex flex-col justify-between h-[400px] overflow-y-auto">
                        <div>
                            <div class="flex items-center justify-between mb-4">
                                <h3 class="font-bold text-sm text-gray-300">
                                    <span id="timeline-date-label">5월 26일 (오늘)</span>의 스케줄 리스트
                                </h3>
                                <button onclick="openAddEventModal()" class="px-3 py-1 bg-slate-900 hover:bg-slate-800 border border-brand-border text-cyan-400 hover:text-white rounded-lg text-xs font-bold transition flex items-center gap-1.5">
                                    <i class="fa-solid fa-plus"></i> 새 일정 등록
                                </button>
                            </div>

                            <!-- 타임라인 카드 세트 (클릭 시 가변적으로 렌더링되도록 구현) -->
                            <div id="timeline-events-container" class="space-y-3">
                                <!-- 이벤트 1: 데일리 스크럼 (Meeting) -->
                                <div class="event-card-item bg-slate-900 border-l-4 border-brand-accent p-4 rounded-r-xl border-y border-r border-brand-border/60 flex items-center justify-between gap-4" data-category="my">
                                    <div class="flex items-start gap-4">
                                        <div class="text-center font-mono text-xs text-gray-400 bg-slate-950 px-2 py-1.5 rounded-lg border border-brand-border/80">
                                            <span class="block text-gray-100 font-bold">10:00</span>
                                            <span>30m</span>
                                        </div>
                                        <div>
                                            <div class="flex items-center gap-2 mb-1">
                                                <span class="px-1.5 py-0.5 bg-blue-500/10 border border-blue-500/20 text-blue-400 text-[10px] rounded font-bold">스프린트 미팅</span>
                                                <span class="text-[11px] text-gray-500"><i class="fa-solid fa-map-pin"></i> 3층 미팅룸 B</span>
                                            </div>
                                            <h4 class="font-bold text-sm text-white">Daily Scrum &amp; UI/UX 설계안 중간 검토</h4>
                                            <p class="text-xs text-gray-400 mt-1">스프린트 24차 진행도 검수 및 피드백 통합 정리</p>
                                        </div>
                                    </div>
                                    <!-- 액션: 원클릭 화상회의 바로가기 -->
                                    <div class="flex items-center gap-2">
                                        <a href="https://zoom.us/" target="_blank" class="px-3 py-1.5 bg-blue-500 hover:bg-blue-600 text-white rounded-lg text-xs font-bold flex items-center gap-1.5 transition">
                                            <i class="fa-solid fa-video"></i> 화상회의
                                        </a>
                                    </div>
                                </div>

                                <!-- 이벤트 2: 배포 일정 (Project) -->
                                <div class="event-card-item bg-slate-900 border-l-4 border-red-500 p-4 rounded-r-xl border-y border-r border-brand-border/60 flex items-center justify-between gap-4" data-category="project">
                                    <div class="flex items-start gap-4">
                                        <div class="text-center font-mono text-xs text-gray-400 bg-slate-950 px-2 py-1.5 rounded-lg border border-brand-border/80">
                                            <span class="block text-gray-100 font-bold">14:00</span>
                                            <span>1h</span>
                                        </div>
                                        <div>
                                            <div class="flex items-center gap-2 mb-1">
                                                <span class="px-1.5 py-0.5 bg-red-500/10 border border-red-500/20 text-red-400 text-[10px] rounded font-bold">인프라/배포</span>
                                                <span class="text-[11px] text-gray-500"><i class="fa-brands fa-jira"></i> DEV-402</span>
                                            </div>
                                            <h4 class="font-bold text-sm text-white">PG 결제대행 실서버 핫픽스 배포</h4>
                                            <p class="text-xs text-gray-400 mt-1">모바일 팝업 결제 에러 현상 개선안 마스터 브랜치 배포 예정</p>
                                        </div>
                                    </div>
                                    <!-- 액션: Jira 바로가기 -->
                                    <div class="flex items-center gap-2">
                                        <span class="text-xs text-gray-500">배포 담당: 이도현</span>
                                    </div>
                                </div>

                                <!-- 이벤트 3: 보상 휴가 현황 (Team/Vacation) -->
                                <div class="event-card-item bg-slate-900 border-l-4 border-emerald-500 p-4 rounded-r-xl border-y border-r border-brand-border/60 flex items-center justify-between gap-4" data-category="team">
                                    <div class="flex items-start gap-4">
                                        <div class="text-center font-mono text-xs text-gray-400 bg-slate-950 px-2 py-1.5 rounded-lg border border-brand-border/80">
                                            <span class="block text-gray-100 font-bold">All Day</span>
                                        </div>
                                        <div>
                                            <div class="flex items-center gap-2 mb-1">
                                                <span class="px-1.5 py-0.5 bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 text-[10px] rounded font-bold">휴가/재택</span>
                                            </div>
                                            <h4 class="font-bold text-sm text-white">김민서 Senior Dev - 대체 휴가</h4>
                                            <p class="text-xs text-gray-400 mt-1">주말 정기 배포 장애 대응 온콜(On-Call) 실적에 따른 보상 적립 연차 사용</p>
                                        </div>
                                    </div>
                                    <!-- 프로필 아바타 -->
                                    <div>
                                        <img src="./DevSync - IT 개발사 스마트 대시보드_files/photo-1494790108377-be9c29b29330" alt="Avatar" class="w-8 h-8 rounded-full border border-emerald-500 object-cover">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 타임라인 푸터 -->
                        <div class="border-t border-brand-border/60 pt-4 flex items-center justify-between text-xs text-gray-500">
                            <span>* 일정 데이터는 Jira, 사내 전자결재와 실시간 갱신 처리됩니다.</span>
                            <span class="text-brand-neonBlue cursor-pointer hover:underline">캘린더 크게보기 <i class="fa-solid fa-up-right-from-square text-[10px]"></i></span>
                        </div>
                    </div>
                </div>
            </section>

            <!-- ROW 3: TWO-COLUMN COLLABORATION & INFRA (자원예약, 팀원 협업 상태, 인프라) -->
            <section class="grid grid-cols-1 lg:grid-cols-12 gap-6">
                <!-- 좌측 7/12: 오늘의 전사 원격/재택/휴가 현황판 (협업 지원용) -->
                <div class="lg:col-span-7 bg-brand-card p-6 rounded-2xl border border-brand-border flex flex-col justify-between shadow-xl">
                    <div>
                        <div class="flex items-center justify-between mb-4">
                            <div class="flex items-center gap-2">
                                <i class="fa-solid fa-users text-cyan-400"></i>
                                <h3 class="font-bold text-gray-200 text-base">오늘의 부서원 상태 공유</h3>
                            </div>
                            <span class="text-xs bg-slate-900 border border-brand-border px-2 py-1 rounded text-gray-400">총 8명 중 3명 외부 근무</span>
                        </div>

                        <div class="space-y-3">
                            <!-- 팀원 1: 재택 -->
                            <div class="flex items-center justify-between bg-slate-950/40 p-3 rounded-xl border border-brand-border/60">
                                <div class="flex items-center gap-3">
                                    <img src="./DevSync - IT 개발사 스마트 대시보드_files/photo-1438761681033-6461ffad8d80" alt="Team Profile" class="w-9 h-9 rounded-full object-cover border border-blue-400">
                                    <div>
                                        <span class="font-bold text-sm text-gray-200">한혜지 대리</span>
                                        <p class="text-[11px] text-gray-400">웹 디자인 파트</p>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <span class="px-2 py-1 bg-blue-500/10 border border-blue-500/20 text-blue-400 text-xs rounded-full font-bold"><i class="fa-solid fa-house-laptop"></i> 재택 근무</span>
                                </div>
                            </div>

                            <!-- 팀원 2: 상주(파견) -->
                            <div class="flex items-center justify-between bg-slate-950/40 p-3 rounded-xl border border-brand-border/60">
                                <div class="flex items-center gap-3">
                                    <img src="./DevSync - IT 개발사 스마트 대시보드_files/photo-1507003211169-0a1dd7228f2d" alt="Team Profile" class="w-9 h-9 rounded-full object-cover border border-purple-400">
                                    <div>
                                        <span class="font-bold text-sm text-gray-200">정재윤 책임</span>
                                        <p class="text-[11px] text-gray-400">백엔드 아키텍트</p>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <span class="px-2 py-1 bg-purple-500/10 border border-purple-500/20 text-purple-400 text-xs rounded-full font-bold"><i class="fa-solid fa-network-wired"></i> 고객사 상주</span>
                                </div>
                            </div>

                            <!-- 팀원 3: 연차 -->
                            <div class="flex items-center justify-between bg-slate-950/40 p-3 rounded-xl border border-brand-border/60">
                                <div class="flex items-center gap-3">
                                    <img src="./DevSync - IT 개발사 스마트 대시보드_files/photo-1494790108377-be9c29b29330" alt="Team Profile" class="w-9 h-9 rounded-full object-cover border border-emerald-500">
                                    <div>
                                        <span class="font-bold text-sm text-gray-200">김민서 수석</span>
                                        <p class="text-[11px] text-gray-400">인프라/보안 파트</p>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <span class="px-2 py-1 bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 text-xs rounded-full font-bold"><i class="fa-solid fa-umbrella"></i> 연차 휴가</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 단축 연락망 -->
                    <p class="text-[11px] text-gray-500 mt-3">* 해당 상태 정보는 슬랙(Slack)의 상태 마크에 실시간 자동 동기화되어 반영됩니다.</p>
                </div>

                <!-- 우측 5/12: 사내 대여 자산 및 회의실 실시간 예약 상황 -->
                <div class="lg:col-span-5 bg-brand-card p-6 rounded-2xl border border-brand-border flex flex-col justify-between shadow-xl">
                    <div>
                        <div class="flex items-center justify-between mb-4">
                            <div class="flex items-center gap-2">
                                <i class="fa-solid fa-box text-cyan-400"></i>
                                <h3 class="font-bold text-gray-200 text-base">공용 테스트 기기 대여</h3>
                            </div>
                            <span class="text-xs text-brand-neonBlue font-bold hover:underline cursor-pointer">대여하기</span>
                        </div>

                        <div class="space-y-2.5">
                            <!-- 자산 1: 맥북 -->
                            <div class="flex items-center justify-between text-xs bg-slate-950 p-2.5 rounded-lg border border-brand-border">
                                <span class="text-gray-300 font-medium"><i class="fa-solid fa-laptop text-gray-500 mr-2"></i>MacBook Pro M3 16" (A-04)</span>
                                <span class="px-2 py-0.5 rounded bg-slate-800 text-gray-400 font-bold">내 보유 기기</span>
                            </div>
                            <!-- 자산 2: 아이폰 -->
                            <div class="flex items-center justify-between text-xs bg-slate-950 p-2.5 rounded-lg border border-brand-border">
                                <span class="text-gray-300 font-medium"><i class="fa-solid fa-mobile-screen-button text-gray-500 mr-2"></i>iPhone 15 Pro (T-iOS-02)</span>
                                <span class="px-2 py-0.5 rounded bg-red-500/10 border border-red-500/20 text-red-400 font-bold">대여 중 (H 대리)</span>
                            </div>
                            <!-- 자산 3: 갤럭시 -->
                            <div class="flex items-center justify-between text-xs bg-slate-950 p-2.5 rounded-lg border border-brand-border">
                                <span class="text-gray-300 font-medium"><i class="fa-solid fa-mobile-screen-button text-gray-500 mr-2"></i>Galaxy S24 Ultra (T-And-09)</span>
                                <span class="px-2 py-0.5 rounded bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 font-bold">대여 가능</span>
                            </div>
                        </div>

                        <!-- 회의실 예약 요약 -->
                        <div class="mt-5 pt-4 border-t border-brand-border/60">
                            <h4 class="text-xs font-bold text-gray-400 mb-2">오늘 내가 예약한 사내 자원</h4>
                            <div class="bg-brand-accent/5 border border-brand-accent/20 p-3 rounded-lg text-xs flex justify-between items-center">
                                <div>
                                    <span class="font-bold text-gray-100 block">3층 미팅룸 B (회의실)</span>
                                    <span class="text-[10px] text-gray-400">사용 예정: 10:00 - 10:30 (데일리 스크럼)</span>
                                </div>
                                <button class="text-red-400 hover:underline">취소</button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </main>
    </div>

    <!-- 3. INTERACTIVE MODAL FOR ADDING EVENT (일정 추가 인터랙션 모달) -->
    <div id="add-event-modal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm transition-all duration-300">
        <div class="bg-brand-card border border-brand-border rounded-2xl w-full max-w-md p-6 shadow-2xl relative">
            <button onclick="closeAddEventModal()" class="absolute top-4 right-4 text-gray-400 hover:text-white text-lg"><i class="fa-solid fa-xmark"></i></button>
            <h3 class="text-lg font-bold text-white mb-4"><i class="fa-solid fa-calendar-plus text-cyan-400 mr-1.5"></i> 새 일정 등록하기</h3>
            
            <form onsubmit="addNewEvent(event)" class="space-y-4">
                <!-- 일정 카테고리 분류 -->
                <div>
                    <label class="block text-xs font-bold text-gray-400 mb-1.5">일정 종류</label>
                    <select id="new-event-cat" class="w-full bg-slate-900 border border-brand-border text-xs rounded-lg p-2.5 text-gray-200 focus:outline-none focus:border-brand-accent">
                        <option value="my">내 업무 일정 (Personal Task)</option>
                        <option value="project">프로젝트/마일스톤 (Jira 연동)</option>
                        <option value="team">팀 휴가/재택 등록 (전자결재연동)</option>
                    </select>
                </div>

                <!-- 일정 타이틀 -->
                <div>
                    <label class="block text-xs font-bold text-gray-400 mb-1.5">일정 타이틀</label>
                    <input type="text" id="new-event-title" required="" class="w-full bg-slate-900 border border-brand-border text-xs rounded-lg p-2.5 text-gray-100 focus:outline-none focus:border-brand-accent" placeholder="예: [프로젝트] AWS 클라우드 아키텍처 중간 미팅">
                </div>

                <!-- 시간 설정 -->
                <div class="grid grid-cols-2 gap-3">
                    <div>
                        <label class="block text-xs font-bold text-gray-400 mb-1.5">시작 시간</label>
                        <input type="time" id="new-event-time" required="" class="w-full bg-slate-900 border border-brand-border text-xs rounded-lg p-2.5 text-gray-100 focus:outline-none focus:border-brand-accent">
                    </div>
                    <div>
                        <label class="block text-xs font-bold text-gray-400 mb-1.5">소요 시간</label>
                        <select id="new-event-duration" class="w-full bg-slate-900 border border-brand-border text-xs rounded-lg p-2.5 text-gray-100 focus:outline-none focus:border-brand-accent">
                            <option value="30m">30 분</option>
                            <option value="1h">1 시간</option>
                            <option value="2h">2 시간</option>
                            <option value="All Day">All Day (온종일)</option>
                        </select>
                    </div>
                </div>

                <!-- 상세 설명 및 회의실 등 리소스 연동 -->
                <div>
                    <label class="block text-xs font-bold text-gray-400 mb-1.5">회의 장소 / 자원 선택</label>
                    <select id="new-event-loc" class="w-full bg-slate-900 border border-brand-border text-xs rounded-lg p-2.5 text-gray-100 focus:outline-none focus:border-brand-accent">
                        <option value="3층 미팅룸 B">3층 대회의실 B</option>
                        <option value="화상 회의 (Zoom)">원격 화상 회의 (Zoom 연동 생성)</option>
                        <option value="기타">장소 없음 / 비대면</option>
                    </select>
                </div>

                <!-- 설명 기재 -->
                <div>
                    <label class="block text-xs font-bold text-gray-400 mb-1.5">일정 상세 설명</label>
                    <textarea id="new-event-desc" rows="2" class="w-full bg-slate-900 border border-brand-border text-xs rounded-lg p-2.5 text-gray-100 focus:outline-none focus:border-brand-accent" placeholder="일정의 세부 업무 범위나 어젠다를 입력하세요."></textarea>
                </div>

                <!-- 승인 버튼 -->
                <button type="submit" class="w-full py-2.5 bg-brand-accent hover:bg-blue-600 text-white rounded-xl text-sm font-bold shadow-lg shadow-brand-accent/20 transition">일정 및 리소스 저장하기</button>
            </form>
        </div>
    </div>


    <!-- ============================================ -->
    <!-- JAVASCRIPT FOR INTERACTIVE DEMO (인터랙션 구현) -->
    <!-- ============================================ -->
    <script>
        // 1. 사이드바 아코디언 메뉴 토글
        function toggleSubmenu(id) {
            const menu = document.getElementById(id);
            const arrow = document.getElementById('arrow-' + id);
            
            if (menu.classList.contains('hidden')) {
                menu.classList.remove('hidden');
                arrow.classList.remove('fa-chevron-down');
                arrow.classList.add('fa-chevron-up');
                if (arrow.classList.contains('text-gray-500')) {
                    arrow.classList.remove('text-gray-500');
                    arrow.classList.add('text-cyan-400');
                }
            } else {
                menu.classList.add('hidden');
                arrow.classList.remove('fa-chevron-up');
                arrow.classList.add('fa-chevron-down');
                arrow.classList.remove('text-cyan-400');
                arrow.classList.add('text-gray-500');
            }
        }

        // 2. 출퇴근 실시간 타이머 및 근무 컨트롤 인터랙션
        let timerInterval = null;
        let totalSeconds = 0; // 초 단위 누적 시간
        let isWorking = false;

        function setWorkLocation(type) {
            const badge = document.getElementById('work-location-badge');
            badge.innerText = type + " 근무";
            
            // 모든 근무지 칩 스타일 초기화 후 활성화 지정
            const types = ['본사', '재택', '외근', '상주'];
            types.forEach(loc => {
                const button = document.getElementById('loc-' + loc);
                if (loc === type) {
                    button.className = "py-1 text-xs rounded-lg font-semibold bg-brand-accent text-white border border-brand-accent transition";
                } else {
                    button.className = "py-1 text-xs rounded-lg font-semibold bg-slate-900 text-gray-400 border border-brand-border hover:text-white transition";
                }
            });
        }

        function triggerCheckIn() {
            if (isWorking) return;
            
            isWorking = true;
            // 출퇴근 버튼 상태 전환
            const checkInBtn = document.getElementById('btn-checkin');
            const checkOutBtn = document.getElementById('btn-checkout');
            
            checkInBtn.className = "w-full py-2.5 bg-slate-800 text-gray-500 border border-brand-border rounded-xl text-sm font-bold cursor-not-allowed transition flex items-center justify-center gap-2";
            checkInBtn.disabled = true;
            
            checkOutBtn.className = "w-full py-2.5 bg-gradient-to-r from-red-500 to-orange-500 hover:brightness-110 text-white rounded-xl text-sm font-bold shadow-lg shadow-red-500/10 transition flex items-center justify-center gap-2 cursor-pointer";
            checkOutBtn.disabled = false;

            // 타이머 작동 시작
            timerInterval = setInterval(() => {
                totalSeconds++;
                updateTimerDisplay();
            }, 1000);
        }

        function triggerCheckOut() {
            if (!isWorking) return;
            
            isWorking = false;
            clearInterval(timerInterval);

            // 출퇴근 버튼 상태 복구
            const checkInBtn = document.getElementById('btn-checkin');
            const checkOutBtn = document.getElementById('btn-checkout');

            checkInBtn.className = "w-full py-2.5 bg-gradient-to-r from-emerald-500 to-teal-500 hover:brightness-110 text-white rounded-xl text-sm font-bold shadow-lg shadow-emerald-500/10 transition flex items-center justify-center gap-2 cursor-pointer";
            checkInBtn.disabled = false;
            
            checkOutBtn.className = "w-full py-2.5 bg-slate-800 text-gray-500 border border-brand-border rounded-xl text-sm font-bold cursor-not-allowed transition flex items-center justify-center gap-2";
            checkOutBtn.disabled = true;

            alert("오늘 하루 수고하셨습니다! 퇴근 처리가 완료되어 슬랙 채널 상태가 'Offline'으로 전환되었습니다.");
        }

        function updateTimerDisplay() {
            const hours = Math.floor(totalSeconds / 3600);
            const minutes = Math.floor((totalSeconds % 3600) / 60);
            const seconds = totalSeconds % 60;

            const format = (num) => String(num).padStart(2, '0');
            document.getElementById('timer-display').innerText = `${format(hours)} : ${format(minutes)} : ${format(seconds)}`;
        }


        // 3. 스마트 일정 위젯 - 퀵 필터 탭 클릭 인터랙션
        function filterEvents(category) {
            const tabs = ['all', 'my', 'project', 'team'];
            
            // 탭 스타일 활성화 처리
            tabs.forEach(tab => {
                const btn = document.getElementById('tab-' + tab);
                if (tab === category) {
                    btn.className = "px-4 py-1.5 text-xs font-semibold rounded-lg text-white bg-brand-accent transition shadow-md";
                } else {
                    btn.className = "px-4 py-1.5 text-xs font-semibold rounded-lg text-gray-400 hover:text-white transition";
                }
            });

            // 이벤트 데이터 필터링 가시화
            const cards = document.querySelectorAll('.event-card-item');
            cards.forEach(card => {
                const cardCategory = card.getAttribute('data-category');
                if (category === 'all' || cardCategory === category) {
                    card.style.display = 'flex';
                } else {
                    card.style.display = 'none';
                }
            });
        }


        // 4. 달력 날짜 변경 및 해당 날짜의 더미 데이터 렌더링
        const mockEventsByDate = {
            26: [
                {
                    time: "10:00", duration: "30m", cat: "my", catLabel: "스프린트 미팅",
                    title: "Daily Scrum & UI/UX 설계안 중간 검토", desc: "스프린트 24차 진행도 검수 및 피드백 통합 정리",
                    loc: "3층 미팅룸 B", action: true, actionType: "zoom"
                },
                {
                    time: "14:00", duration: "1h", cat: "project", catLabel: "인프라/배포",
                    title: "PG 결제대행 실서버 핫픽스 배포", desc: "모바일 팝업 결제 에러 현상 개선안 마스터 브랜치 배포 예정",
                    loc: "DEV-402", action: false
                },
                {
                    time: "All Day", duration: "", cat: "team", catLabel: "휴가/재택",
                    title: "김민서 Senior Dev - 대체 휴가", desc: "주말 정기 배포 장애 대응 온콜(On-Call) 실적에 따른 보상 적립 연차 사용",
                    loc: "", action: false, avatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=60&h=60"
                }
            ],
            27: [
                {
                    time: "13:00", duration: "2h", cat: "project", catLabel: "인프라 작업",
                    title: "AWS RDS 데이터베이스 마이그레이션", desc: "고객 수 증가에 따른 읽기 전용 복제본 스케일 아웃 및 분산 작업",
                    loc: "Cloud DB", action: false
                },
                {
                    time: "16:00", duration: "1h", cat: "my", catLabel: "정기 회의",
                    title: "전사 개발 표준화 테크 세미나", desc: "사내 공통 컴포넌트 라이브러리 v2.0 공유 및 토론회",
                    loc: "Zoom 온라인 세션", action: true, actionType: "zoom"
                }
            ],
            28: [
                {
                    time: "11:00", duration: "1h", cat: "team", catLabel: "클라이언트 미팅",
                    title: "네이버 비즈니스 커머스 협력 미팅 (대면)", desc: "API 연동 제휴 관련 요구사항 검수 및 일정 협의",
                    loc: "1층 고객 미팅 센터", action: false
                }
            ]
        };

        function selectCalendarDate(day) {
            // 날짜 레이블 변경
            const label = document.getElementById('timeline-date-label');
            label.innerText = `5월 ${day}일`;

            // 이전 달력 일자 하이라이트 클래스 제거 및 지정
            const dates = [26, 27, 28];
            dates.forEach(d => {
                const cell = document.getElementById('cal-date-' + d);
                if (d === day) {
                    cell.className = "text-white py-2 bg-brand-accent/40 border border-brand-accent rounded-lg cursor-pointer relative flex flex-col items-center justify-center font-bold";
                } else {
                    cell.className = "text-gray-300 py-2 hover:bg-slate-900 rounded-lg cursor-pointer relative flex flex-col items-center justify-center";
                }
            });

            // 해당 날짜 일정 데이터 새로 그리기 (더미 바인딩)
            const container = document.getElementById('timeline-events-container');
            container.innerHTML = ""; // 기존 비우기

            const events = mockEventsByDate[day];
            if (!events || events.length === 0) {
                container.innerHTML = `
                    <div class="text-center py-12 text-xs text-gray-500">
                        <i class="fa-regular fa-calendar-xmark text-4xl mb-3 block text-gray-600"></i>
                        해당 날짜에 등록된 일정이 없습니다.
                    </div>`;
                return;
            }

            events.forEach(ev => {
                let borderCol = "border-brand-accent";
                let catBadgeCol = "bg-blue-500/10 border-blue-500/20 text-blue-400";
                
                if (ev.cat === 'project') {
                    borderCol = "border-red-500";
                    catBadgeCol = "bg-red-500/10 border-red-500/20 text-red-400";
                } else if (ev.cat === 'team') {
                    borderCol = "border-emerald-500";
                    catBadgeCol = "bg-emerald-500/10 border-emerald-500/20 text-emerald-400";
                }

                let actionHtml = "";
                if (ev.action && ev.actionType === 'zoom') {
                    actionHtml = `
                        <a href="https://zoom.us" target="_blank" class="px-3 py-1.5 bg-blue-500 hover:bg-blue-600 text-white rounded-lg text-xs font-bold flex items-center gap-1.5 transition">
                            <i class="fa-solid fa-video"></i> 화상회의
                        </a>`;
                } else if (ev.avatar) {
                    actionHtml = `<img src="${ev.avatar}" alt="Avatar" class="w-8 h-8 rounded-full border border-emerald-500 object-cover">`;
                }

                const cardHtml = `
                    <div class="event-card-item bg-slate-900 border-l-4 ${borderCol} p-4 rounded-r-xl border-y border-r border-brand-border/60 flex items-center justify-between gap-4" data-category="${ev.cat}">
                        <div class="flex items-start gap-4">
                            <div class="text-center font-mono text-xs text-gray-400 bg-slate-950 px-2 py-1.5 rounded-lg border border-brand-border/80">
                                <span class="block text-gray-100 font-bold">${ev.time}</span>
                                <span>${ev.duration}</span>
                            </div>
                            <div>
                                <div class="flex items-center gap-2 mb-1">
                                    <span class="px-1.5 py-0.5 ${catBadgeCol} text-[10px] rounded font-bold">${ev.catLabel}</span>
                                    ${ev.loc ? `<span class="text-[11px] text-gray-500"><i class="fa-solid fa-map-pin"></i> ${ev.loc}</span>` : ""}
                                </div>
                                <h4 class="font-bold text-sm text-white">${ev.title}</h4>
                                <p class="text-xs text-gray-400 mt-1">${ev.desc}</p>
                            </div>
                        </div>
                        <div class="flex items-center gap-2">
                            ${actionHtml}
                        </div>
                    </div>`;
                
                container.innerHTML += cardHtml;
            });
        }


        // 5. 모달 제어 기능
        function openAddEventModal() {
            const modal = document.getElementById('add-event-modal');
            modal.classList.remove('hidden');
        }

        function closeAddEventModal() {
            const modal = document.getElementById('add-event-modal');
            modal.classList.add('hidden');
        }

        function addNewEvent(e) {
            e.preventDefault();
            
            const cat = document.getElementById('new-event-cat').value;
            const title = document.getElementById('new-event-title').value;
            const time = document.getElementById('new-event-time').value;
            const duration = document.getElementById('new-event-duration').value;
            const loc = document.getElementById('new-event-loc').value;
            const desc = document.getElementById('new-event-desc').value;

            // 더미 26일 자원에 추가
            const newEv = {
                time: time,
                duration: duration,
                cat: cat,
                catLabel: cat === 'my' ? "내 스케줄" : (cat === 'project' ? "프로젝트" : "부서 휴가/공유"),
                title: title,
                desc: desc || "회의 상세 안건 공유 예정",
                loc: loc,
                action: loc.includes("Zoom") ? true : false,
                actionType: "zoom"
            };

            // 만약 선택된 날짜에 매핑하여 추가
            if (!mockEventsByDate[26]) {
                mockEventsByDate[26] = [];
            }
            mockEventsByDate[26].push(newEv);

            // 타임라인 다시 그리기
            selectCalendarDate(26);
            
            // 모달 초기화 및 닫기
            document.getElementById('new-event-title').value = "";
            document.getElementById('new-event-desc').value = "";
            closeAddEventModal();

            alert("새로운 일정이 안전하게 사내 스케줄러 데이터베이스에 동기화 완료되었습니다.");
        }
    </script>

</body></html>