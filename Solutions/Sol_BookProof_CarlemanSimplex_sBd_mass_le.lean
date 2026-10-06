-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.sBd_mass_le
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Theorems.Thm_BookProof_CarlemanSimplex_sBd_multiplicity
import Theorems.Thm_BookProof_CarlemanTwoStep_sum_range_of_multiplicity
open BookProof.CarlemanSimplex




open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}
variable {lam : (Fin d →₀ ℕ) → ℝ} {w : Fin d → ℂ} {W M : Fin d → Fin d → ℂ} {z : ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {B : ℝ}
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B) (k M : ℕ) :
    ∑ N ∈ Finset.range M, ∑ a ∈ sBd d N k, ‖u a‖ ^ 2 ≤ (k : ℝ) * B := sum_range_of_multiplicity k hbes (fun N => sBd d N k) (sBd_multiplicity k) M
