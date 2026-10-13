-- Generated from ChapterNsLinearKoopmanEsa.lean — solution of BookProof.NsLinearKoopmanEsa.linKoopmanOp_eq_fqOp
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_linKvnPoly_eq_fqPoly
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_subtype_comp_coreRepPoly_op
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
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
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) :
    linKoopmanOp A c = fqOp 0 0 (fun j i => A i j) 0 c := by

  rw [linKoopmanOp, subtype_comp_coreRepPoly_op, linKvnPoly_eq_fqPoly, fqOp]
