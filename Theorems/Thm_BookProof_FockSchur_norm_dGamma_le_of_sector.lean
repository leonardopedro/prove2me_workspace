-- Generated from ChapterFockSchurEsa.lean — theorem BookProof.FockSchur.norm_dGamma_le_of_sector
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

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}



open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

theorem BookProof.FockSchur.norm_dGamma_le_of_sector (hK : SchurBound col K) (hherm : IsHermCol col) (hK0 : 0 ≤ K)
    {n : ℕ} {u : FockAlg} (hu : InSector n u) :
    ‖toLp (dGamma col u)‖ ≤ K * n * ‖toLp u‖ := by sorry
