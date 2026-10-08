-- Generated from ChapterCarlemanGeneralHop.lean — theorem BookProof.CarlemanGeneralHop.flux_bound_gen
import Definitions.Def_ChapterHermiteCarlemanEsa
import Definitions.Def_ChapterCarlemanTwoStep
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
open BookProof.CarlemanGeneralHop



open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {u : (Fin d →₀ ℕ) → ℂ}

theorem BookProof.CarlemanGeneralHop.flux_bound_gen {w : ℂ} {c : (Fin d →₀ ℕ) → ℝ} {p m : Fin d →₀ ℕ}
    (F G : Finset (Fin d →₀ ℕ)) (hzero : ∀ a ∈ F, a ∉ G → c a = 0)
    {Cn : ℝ} (hCn : 0 ≤ Cn) (hC : ∀ a ∈ G, |c a| ≤ Cn) :
    |(∑ a ∈ F, rtG u w c p m a).im|
      ≤ Cn * (‖w‖ * ((∑ a ∈ G, (‖u a‖ ^ 2 + ‖u (hshift p m a)‖ ^ 2)) / 2)) := by sorry
