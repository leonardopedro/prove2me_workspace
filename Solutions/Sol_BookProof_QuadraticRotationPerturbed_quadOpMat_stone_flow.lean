-- Generated from ChapterQuadraticRotationPerturbed.lean — solution of BookProof.QuadraticRotationPerturbed.quadOpMat_stone_flow
import Mathlib
import Definitions.Def_ChapterQuadraticRotationPerturbed
import Theorems.Thm_BookProof_QuadraticRotation_quadOpMat_essentiallySelfAdjoint
import Theorems.Thm_BookProof_QuadraticRotation_quadOpMat_symmetric
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterNavierStokesSignFlip
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterKatoRellichDeficiency
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.QuadraticRotationPerturbed




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.NavierStokesFlow.SignFlip
open BookProof.HyperbolicQuadratic
open BookProof.HermiteRelative
open BookProof.QuadraticRotation
open BookProof.KatoRellich
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.EsaClosure
open BookProof.HermiteProductCore
open BookProof.StoneBridge

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {A : Matrix (Fin d) (Fin d) ℝ} (hA : A.IsHermitian) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (quadOpMat A) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ polyGaussCore_dense (quadOpMat_symmetric hA)
      (quadOpMat_essentiallySelfAdjoint hA)
