-- Generated from ChapterFockWeightedSchurEsa.lean — theorem BookProof.FockWeightedSchur.im_inner_dGamma_wgt_bound
import Definitions.Def_ChapterCoreBoundsEsa
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization
open BookProof.FockWeightedSchur



open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {w : ℕ → ℝ}
variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

theorem BookProof.FockWeightedSchur.im_inner_dGamma_wgt_bound (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col)
    (hBg : WCommBound w col B) (u : FockAlg) :
    |(-2 : ℝ) * (inner ℂ (toLp (dGamma col u)) (toLp (wgt w u)) : ℂ).im|
      ≤ B * (inner ℂ (toLp u) (toLp (wgt w u)) : ℂ).re := by sorry
