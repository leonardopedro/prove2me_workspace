-- Generated from ChapterQgCouplingDGammaSum.lean — theorem BookProof.QgCouplingDGammaSum.creVec_add
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
open BookProof.QgCouplingDGammaSum

variable {ι : Type*}



open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

theorem BookProof.QgCouplingDGammaSum.creVec_add (v w : ℕ →₀ ℂ) (x : FockAlg) :
    creVec (v + w) x = creVec v x + creVec w x := by sorry
