-- Generated from ChapterFockSchurEsa.lean — theorem BookProof.FockSchur.sum_norm_col_le
import Definitions.Def_ChapterFockSecondQuantization
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
open BookProof.FockSchur



open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

theorem BookProof.FockSchur.sum_norm_col_le {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ} (hK : SchurBound col K) (k : ℕ)
    (L : Finset ℕ) : ∑ j ∈ L, ‖(col k) j‖ ≤ K := by sorry
