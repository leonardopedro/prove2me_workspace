-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.ladderOrd_zero
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_hn_zero_vec
import Theorems.Thm_BookProof_HermiteLadder_pgLp_zero'
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : LadderOrd (0 : MvPolynomial (Fin d) ℂ →ₗ[ℂ] _) n := fun _ => ⟨0, ENNReal.zero_ne_top, fun p => by simp [pgLp_zero', hn_zero_vec]⟩
