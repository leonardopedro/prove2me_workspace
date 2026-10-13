-- Generated from ChapterNsLinearKoopmanEsa.lean — solution of BookProof.NsLinearKoopmanEsa.linKoopman_esa
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_linKoopmanOp_eq_fqOp
import Theorems.Thm_BookProof_FullQuadratic_fqOp_essentiallySelfAdjoint
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterHermiteProductCore
open BookProof.NsLinearKoopmanEsa




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.NsKoopman
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.FockSecondQuantization BookProof.QuadFockEsa
open BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (linKoopmanOp A c) := by

  rw [linKoopmanOp_eq_fqOp]
  exact fqOp_essentiallySelfAdjoint _ _ _ _ _
