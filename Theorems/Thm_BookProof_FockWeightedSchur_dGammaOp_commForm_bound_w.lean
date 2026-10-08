-- Generated from ChapterFockWeightedSchurEsa.lean — theorem BookProof.FockWeightedSchur.dGammaOp_commForm_bound_w
import Definitions.Def_ChapterCoreBoundsEsa
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockWeightedSchur



open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {w : ℕ → ℝ}
variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

theorem BookProof.FockWeightedSchur.dGammaOp_commForm_bound_w (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col)
    (hBg : WCommBound w col B) (x : lpFiniteModes Conf) :
    |(-2 : ℝ) * (inner ℂ (dGammaOp col x)
        ((diagMax (wSym w) (inclC (wSym w) x) : Fock)) : ℂ).im|
      ≤ B * (inner ℂ ((x : Fock)) ((diagMax (wSym w) (inclC (wSym w) x) : Fock)) : ℂ).re := by sorry
