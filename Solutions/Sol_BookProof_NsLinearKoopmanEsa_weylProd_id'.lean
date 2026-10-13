-- Generated from ChapterNsLinearKoopmanEsa.lean — solution of BookProof.NsLinearKoopmanEsa.weylProd_id'
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
import Definitions.Def_ChapterHermiteProductCore
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
open BookProof.YangMillsHermite

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (S : Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    weylProd S LinearMap.id = S := by

  simp only [weylProd, LinearMap.comp_id, LinearMap.id_comp]
  rw [← two_smul ℂ S, smul_smul]
  norm_num
