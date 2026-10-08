-- Generated from ChapterQgCouplingDGammaSum.lean — theorem BookProof.QgCouplingDGammaSum.coupling_esa_dGamma
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.FockOneParticleGap
open BookProof.FockSecondQuantization
open BookProof.QgCouplingDGammaSum



open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}


theorem BookProof.QgCouplingDGammaSum.coupling_esa_dGamma {s : Finset ι} {cols : ι → ℕ → (ℕ →₀ ℂ)} {lam : ℕ → ℝ}
    (hlam : ∀ k, 0 ≤ lam k) (hdiag : (fun k => ∑ i ∈ s, cols i k) = diagCol lam) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (∑ i ∈ s, dGammaOp (cols i)) := by sorry
