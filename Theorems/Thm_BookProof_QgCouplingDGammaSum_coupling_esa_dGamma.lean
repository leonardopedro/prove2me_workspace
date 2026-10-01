-- Generated from ChapterQgCouplingDGammaSum.lean — theorem BookProof.QgCouplingDGammaSum.coupling_esa_dGamma
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
open BookProof.QgCouplingDGammaSum

variable {ι : Type*}



open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

theorem BookProof.QgCouplingDGammaSum.coupling_esa_dGamma {s : Finset ι} {cols : ι → ℕ → (ℕ →₀ ℂ)} {lam : ℕ → ℝ}
    (hlam : ∀ k, 0 ≤ lam k) (hdiag : (fun k => ∑ i ∈ s, cols i k) = diagCol lam) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (∑ i ∈ s, dGammaOp (cols i)) := by sorry
