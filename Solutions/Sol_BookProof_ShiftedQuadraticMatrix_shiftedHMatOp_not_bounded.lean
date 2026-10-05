-- Generated from ChapterShiftedQuadraticMatrixEsa.lean — solution of BookProof.ShiftedQuadraticMatrix.shiftedHMatOp_not_bounded
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticMatrixEsa
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_mulVec_matShiftVec
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_mulVec_matBoostVec
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_entries_symm
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_shiftedHMatOp_rotConj_not_bounded
import Theorems.Thm_BookProof_QuadraticRotation_exists_rotConj_eigenvalues
open BookProof.ShiftedQuadraticMatrix




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.QuadraticRotation
open BookProof.ShiftedHermiteCore
open BookProof.ShiftedQuadratic
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {A : Matrix (Fin d) (Fin d) ℝ}
    (hA : A.IsHermitian) (hdet : IsUnit A.det) (b b' : Fin d → ℝ) (i : Fin d) :
    ¬ ∃ C : ℝ, ∀ f : polyGaussCoreT (matShiftVec A b) (matBoostVec A b'),
        ‖shiftedHMatOp (matShiftVec A b) (matBoostVec A b') A b b' f‖
          ≤ C * ‖(f : L2d d)‖ := by

  obtain ⟨O, hO, hAO⟩ := exists_rotConj_eigenvalues hA
  have hsym := entries_symm hA
  have heig : hA.eigenvalues i ≠ 0 := by
    have hprod : (∏ j, hA.eigenvalues j) ≠ 0 := by
      have := hA.det_eq_prod_eigenvalues
      simp only [RCLike.ofReal_real_eq_id, id_eq] at this
      rw [← this]
      exact isUnit_iff_ne_zero.mp hdet
    exact fun h0 => hprod (Finset.prod_eq_zero (Finset.mem_univ i) h0)
  rw [hAO] at hsym hdet ⊢
  exact shiftedHMatOp_rotConj_not_bounded hO _ _ _ b b' hsym
    (mulVec_matShiftVec hdet b) (mulVec_matBoostVec hdet b') heig
