-- Generated from ChapterNsLinearKoopmanEsa.lean — solution of BookProof.NsLinearKoopmanEsa.nsKoopman_stokes_esa
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_linKoopman_esa
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_drift_eq_linDrift_of_stokes
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterYangMillsHermite
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
open BookProof.ChapterF7
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (S : NsSystem d) (hB : S.bcoef = 0) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (nsKoopmanOp S) := by

  have h : kvnPoly S = linKvnPoly (stokesMat S) 0 := by
    rw [kvnPoly, linKvnPoly]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [drift_eq_linDrift_of_stokes S hB i]
  have h2 : nsKoopmanOp S = linKoopmanOp (stokesMat S) 0 := by
    rw [nsKoopmanOp, linKoopmanOp, h]
  rw [h2]
  exact linKoopman_esa _ _
