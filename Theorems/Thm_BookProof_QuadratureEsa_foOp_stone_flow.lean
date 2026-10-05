-- Generated from ChapterQuadratureEsa.lean — theorem BookProof.QuadratureEsa.foOp_stone_flow
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.EsaClosure
open BookProof.HermiteProductCore
open BookProof.HermiteRelative
open BookProof.StoneBridge
open BookProof.QuadratureEsa

variable {d : ℕ}



open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent


theorem BookProof.QuadratureEsa.foOp_stone_flow (b b' : Fin d → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (foOp b b') T.op ∧ IsStoneFlow T U := by sorry
