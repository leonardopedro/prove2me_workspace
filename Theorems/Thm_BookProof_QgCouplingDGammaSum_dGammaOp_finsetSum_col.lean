-- Generated from ChapterQgCouplingDGammaSum.lean — theorem BookProof.QgCouplingDGammaSum.dGammaOp_finsetSum_col
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
open BookProof.QgCouplingDGammaSum

variable {ι : Type*}



open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

theorem BookProof.QgCouplingDGammaSum.dGammaOp_finsetSum_col (s : Finset ι) (cols : ι → ℕ → (ℕ →₀ ℂ))
    (x : lpFiniteModes Conf) :
    dGammaOp (fun k => ∑ i ∈ s, cols i k) x = ∑ i ∈ s, dGammaOp (cols i) x := by sorry
