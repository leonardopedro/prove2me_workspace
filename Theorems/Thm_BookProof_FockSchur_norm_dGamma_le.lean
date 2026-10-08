-- Generated from ChapterFockSchurEsa.lean — theorem BookProof.FockSchur.norm_dGamma_le
import Definitions.Def_ChapterCoreBoundsEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterYangMillsFriedrichs
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization
open BookProof.FockSchur



open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

theorem BookProof.FockSchur.norm_dGamma_le (hK : SchurBound col K) (hherm : IsHermCol col) (hK0 : 0 ≤ K)
    (u : FockAlg) :
    ‖toLp (dGamma col u)‖ ^ 2 ≤ K ^ 2 * ∑ α ∈ u.support, ((ndeg α : ℝ)) ^ 2 * ‖u α‖ ^ 2 := by sorry
