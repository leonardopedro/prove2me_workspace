-- Generated from ChapterQuadraticRotationPerturbed.lean — solution of BookProof.QuadraticRotationPerturbed.quadOpMat_rotConj_add_firstOrder_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterQuadraticRotationPerturbed
import Theorems.Thm_BookProof_QuadraticRotationPerturbed_rotU_mem_core
import Theorems.Thm_BookProof_QuadraticRotationPerturbed_rotVec_transpose
import Theorems.Thm_BookProof_QuadraticRotationPerturbed_rotU_intertwine
import Theorems.Thm_BookProof_HermiteRelative_quadOp_add_firstOrder_essentiallySelfAdjoint
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_essentiallySelfAdjointOn_of_intertwine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterNavierStokesSignFlip
import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterKatoRellichDeficiency
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterHyperbolicQuadraticEsa
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
open BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution
    {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) (c : Fin d → ℝ) {c0 : ℝ} (hc0 : 0 < c0)
    (hc : ∀ i, c0 ≤ c i) (b b' : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (quadOpMat (rotConj O c) + foOp b b') := by

  have hT := quadOp_add_firstOrder_essentiallySelfAdjoint c hc0 hc (rotVec Oᵀ b) (rotVec Oᵀ b')
  have htrans := essentiallySelfAdjointOn_of_intertwine (rotU hO)
    (quadOp c + foOp (rotVec Oᵀ b) (rotVec Oᵀ b'))
    (quadOpMat (rotConj O c) + foOp (rotVec O (rotVec Oᵀ b)) (rotVec O (rotVec Oᵀ b')))
    (rotU_mem_core hO) (fun v => rotU_intertwine hO c _ _ v) hT
  rwa [rotVec_transpose hO, rotVec_transpose hO] at htrans
