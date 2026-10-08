-- Generated from ChapterFockWeightedSchurEsa.lean — theorem BookProof.FockWeightedSchur.diagMax_wSym_eq
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

theorem BookProof.FockWeightedSchur.diagMax_wSym_eq (x : lpFiniteModes Conf) :
    (diagMax (wSym w) (inclC (wSym w) x) : Fock) = toLp (wgt w (fockEquiv.symm x)) := by sorry
