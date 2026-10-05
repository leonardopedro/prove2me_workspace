-- Generated from ChapterNsLinearKoopmanEsa.lean — theorem BookProof.NsLinearKoopmanEsa.linKoopman_stone_flow
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterQuadraticFockEsa
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.EsaClosure
open BookProof.FullQuadratic
open BookProof.HermiteProductCore
open BookProof.StoneBridge
open BookProof.NsLinearKoopmanEsa

variable {d : ℕ}



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.FockSecondQuantization BookProof.QuadFockEsa

noncomputable section


theorem BookProof.NsLinearKoopmanEsa.linKoopman_stone_flow (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (linKoopmanOp A c) T.op ∧ IsStoneFlow T U := by sorry
