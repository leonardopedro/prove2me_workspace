-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.foOp_stone_flow
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
import Theorems.Thm_BookProof_QuadratureEsa_foOp_essentiallySelfAdjoint
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.QuadratureEsa




open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.EsaClosure
open BookProof.HermiteProductCore
open BookProof.StoneBridge

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b b' : Fin d → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (foOp b b') T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ polyGaussCore_dense (foOp_symmetric b b')
      (foOp_essentiallySelfAdjoint b b')
