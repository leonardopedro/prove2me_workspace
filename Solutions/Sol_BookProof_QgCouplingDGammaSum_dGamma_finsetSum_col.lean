-- Generated from ChapterQgCouplingDGammaSum.lean — solution of BookProof.QgCouplingDGammaSum.dGamma_finsetSum_col
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
import Theorems.Thm_BookProof_QgCouplingDGammaSum_creVec_finsetSum
import Theorems.Thm_BookProof_FockSecondQuantization_dGamma_eq_sum
open BookProof.QgCouplingDGammaSum




open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (s : Finset ι) (cols : ι → ℕ → (ℕ →₀ ℂ)) (u : FockAlg) :
    dGamma (fun k => ∑ i ∈ s, cols i k) u = ∑ i ∈ s, dGamma (cols i) u := by

  classical
  rw [dGamma_eq_sum _ (Finset.Subset.refl (modes u))]
  have hterm : ∀ k ∈ modes u,
      creVec (∑ i ∈ s, cols i k) (annA k u) = ∑ i ∈ s, creVec (cols i k) (annA k u) :=
    fun k _ => creVec_finsetSum s (fun i => cols i k) (annA k u)
  rw [Finset.sum_congr rfl hterm, Finset.sum_comm]
  exact Finset.sum_congr rfl fun i _ =>
    (dGamma_eq_sum (cols i) (Finset.Subset.refl (modes u))).symm
