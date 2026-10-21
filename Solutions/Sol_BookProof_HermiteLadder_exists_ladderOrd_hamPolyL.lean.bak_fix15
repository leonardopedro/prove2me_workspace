-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.exists_ladderOrd_hamPolyL
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_LadderOrd_mono
import Theorems.Thm_BookProof_HermiteLadder_LadderOrd_add
import Theorems.Thm_BookProof_HermiteLadder_LadderOrd_neg
import Theorems.Thm_BookProof_HermiteLadder_LadderOrd_comp
import Theorems.Thm_BookProof_HermiteLadder_LadderOrd_sum
import Theorems.Thm_BookProof_HermiteLadder_exists_ladderOrd_mulL
import Theorems.Thm_BookProof_HermiteLadder_ladderOrd_coreDL
import Theorems.Thm_BookProof_HermiteLadder_hamPolyL_eq
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (S : Finset (Fin d)) (q : MvPolynomial (Fin d) ℂ) :
    ∃ n, LadderOrd (hamPolyL S q) n := by

  obtain ⟨n, h⟩ := exists_ladderOrd_mulL q
  refine ⟨max 2 n, ?_⟩
  rw [hamPolyL_eq]
  exact ((LadderOrd.sum S fun j _ => (ladderOrd_coreDL j).comp (ladderOrd_coreDL j)).neg.mono
    (le_max_left _ _)).add (h.mono (le_max_right _ _))
