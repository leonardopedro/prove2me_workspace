-- Generated from ChapterQgCouplingDGammaSum.lean — solution of BookProof.QgCouplingDGammaSum.comparison_friedrichs
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
import Theorems.Thm_BookProof_QgCouplingDGammaSum_isHermCol_finsetSum
import Theorems.Thm_BookProof_QgCouplingDGammaSum_isPosCol_finsetSum
import Theorems.Thm_BookProof_QgCouplingDGammaSum_isHermCol_numberCol
import Theorems.Thm_BookProof_QgCouplingDGammaSum_isPosCol_numberCol
import Theorems.Thm_BookProof_QgCouplingDGammaSum_isHermCol_add
import Theorems.Thm_BookProof_QgCouplingDGammaSum_isPosCol_add
import Theorems.Thm_BookProof_FockSecondQuantization_dGamma_friedrichs_extension
open BookProof.QgCouplingDGammaSum




open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {s : Finset ι} {cols : ι → ℕ → (ℕ →₀ ℂ)}
    (hherm : ∀ i ∈ s, IsHermCol (cols i)) (hpos : ∀ i ∈ s, IsPosCol (cols i)) :
    ∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
      IsPositiveSelfAdjointExtension (dGammaOp (comparisonCol s cols)) A :=
  dGamma_friedrichs_extension
      (isHermCol_add (isHermCol_finsetSum hherm) isHermCol_numberCol)
      (isPosCol_add (isPosCol_finsetSum hpos) isPosCol_numberCol)
