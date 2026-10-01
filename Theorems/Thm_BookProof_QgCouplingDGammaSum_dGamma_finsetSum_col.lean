-- Generated from ChapterQgCouplingDGammaSum.lean — theorem BookProof.QgCouplingDGammaSum.dGamma_finsetSum_col
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
open BookProof.QgCouplingDGammaSum

variable {ι : Type*}



open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

theorem BookProof.QgCouplingDGammaSum.dGamma_finsetSum_col (s : Finset ι) (cols : ι → ℕ → (ℕ →₀ ℂ)) (u : FockAlg) :
    dGamma (fun k => ∑ i ∈ s, cols i k) u = ∑ i ∈ s, dGamma (cols i) u := by sorry
