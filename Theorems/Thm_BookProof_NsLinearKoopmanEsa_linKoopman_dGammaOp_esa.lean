-- Generated from ChapterNsLinearKoopmanEsa.lean — theorem BookProof.NsLinearKoopmanEsa.linKoopman_dGammaOp_esa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterQuadraticFockEsa
open BookProof.FockSecondQuantization
open BookProof.FullQuadratic
open BookProof.QuadFockEsa
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


theorem BookProof.NsLinearKoopmanEsa.linKoopman_dGammaOp_esa (e : ℕ ≃ (Fin d →₀ ℕ)) (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) :
    EssentiallySelfAdjointOn (BookProof.NavierStokesFlow.lpFiniteModes Conf)
      (dGammaOp (hermCol e (linKvnPoly A c))) := by sorry
