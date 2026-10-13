-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — solution of BookProof.KoopmanLyapunov.quadForm_mulCoreOp
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_coe_op
import Theorems.Thm_BookProof_YangMillsHermite_inner_pgLp_pgLp
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.KoopmanLyapunov




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman
open BookProof.ChapterF7
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (E : MvPolynomial (Fin d) ℂ) (x : polyGaussCore (d := d)) :
    quadForm (mulCoreOp E) x
      = (gpair ((coreRepPoly d).equiv.symm x) (E * (coreRepPoly d).equiv.symm x)).re := by

  have h1 : mulCoreOp E x = pgLp (E * (coreRepPoly d).equiv.symm x) :=
    (coreRepPoly d).coe_op (mulOp E) x
  rw [quadForm, h1, coe_core_eq, inner_pgLp_pgLp]
  rfl
