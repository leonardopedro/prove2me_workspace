-- Generated from ChapterShiftedQuadraticDegenerate.lean — solution of BookProof.ShiftedQuadraticDegenerate.exists_equilibrium_iff
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticDegenerate
import Theorems.Thm_BookProof_ShiftedQuadraticDegenerate_equilibrium_orthogonal_to_kernel
import Theorems.Thm_BookProof_ShiftedQuadraticDegenerate_exists_equilibrium
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_entries_symm
open BookProof.ShiftedQuadraticDegenerate




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HyperbolicQuadratic
open BookProof.QuadraticRotation
open BookProof.ShiftedHermiteCore
open BookProof.ShiftedQuadratic
open BookProof.ShiftedQuadraticMatrix
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.StoneEigenflow

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {A : Matrix (Fin d) (Fin d) ℝ} (hA : A.IsHermitian)
    (w : Fin d → ℝ) :
    (∃ a : Fin d → ℝ, ∀ i, ∑ j, A i j * a j = w i)
      ↔ ∀ v : Fin d → ℝ, (∀ i, ∑ j, A i j * v j = 0) → ∑ i, w i * v i = 0 := by

  refine ⟨fun ⟨a, ha⟩ v hv => equilibrium_orthogonal_to_kernel (entries_symm hA) ha hv,
    fun hw => exists_equilibrium hA hw⟩
