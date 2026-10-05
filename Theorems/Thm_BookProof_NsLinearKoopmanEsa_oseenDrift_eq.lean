-- Generated from ChapterNsLinearKoopmanEsa.lean — theorem BookProof.NsLinearKoopmanEsa.oseenDrift_eq
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterQuadraticFockEsa
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
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


theorem BookProof.NsLinearKoopmanEsa.oseenDrift_eq (S : NsSystem d) (ubar u : Fin d → ℝ) (i : Fin d) :
    driftAt S u i
      = linDriftAt (oseenMat S ubar) (oseenConst S ubar) u i
        + ∑ j, ∑ k, S.bcoef i j k * (u j - ubar j) * (u k - ubar k) := by sorry
