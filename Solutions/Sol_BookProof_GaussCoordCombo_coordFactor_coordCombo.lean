-- Generated from ChapterGaussCoordCombo.lean — solution of BookProof.GaussCoordCombo.coordFactor_coordCombo
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
import Theorems.Thm_BookProof_GaussCoordCombo_pderiv_coordCombo_of_ne
import Theorems.Thm_BookProof_GaussCoordCombo_gaussInt_coordCombo_sq
open BookProof.GaussCoordCombo




open MvPolynomial BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (c : ℕ → ℝ) (p K : ℕ) :
    CoordFactor i (coordCombo i c p K) (coordComboSum c p K) := ⟨fun _ hj => pderiv_coordCombo_of_ne hj c p K, fun _ hR => gaussInt_coordCombo_sq i c p K hR⟩
