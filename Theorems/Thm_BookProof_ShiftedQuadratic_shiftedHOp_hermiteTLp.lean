-- Generated from ChapterShiftedQuadraticEsa.lean — theorem BookProof.ShiftedQuadratic.shiftedHOp_hermiteTLp
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticEsa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterShiftedHermiteCore
import Definitions.Def_ChapterA4
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.HyperbolicQuadratic
open BookProof.ShiftedHermiteCore

variable {d : ℕ}



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.ShiftedHermiteCore
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section


theorem BookProof.ShiftedQuadratic.shiftedHOp_hermiteTLp (c b b' : Fin d → ℝ) (hc : ∀ i, c i ≠ 0) (α : Fin d →₀ ℕ)
    (h : hermiteTLp (shiftVec c b) (boostVec c b') α
      ∈ polyGaussCoreT (shiftVec c b) (boostVec c b')) :
    shiftedHOp (shiftVec c b) (boostVec c b') c b b' ⟨_, h⟩
      = (((quadSymbol c α + shiftConst c b b' : ℝ)) : ℂ)
          • hermiteTLp (shiftVec c b) (boostVec c b') α := by sorry
