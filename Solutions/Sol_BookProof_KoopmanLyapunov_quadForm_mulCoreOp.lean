-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — solution of BookProof.KoopmanLyapunov.quadForm_mulCoreOp
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_coe_op
import Theorems.Thm_BookProof_YangMillsHermite_inner_pgLp_pgLp
open BookProof.KoopmanLyapunov




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine

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
