-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.nsElimSubst_resPoly
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Theorems.Thm_BookProof_NsFullEuler_nsElimSubst_advect
import Theorems.Thm_BookProof_NsFullEuler_nsElimSubst_pressure
import Theorems.Thm_BookProof_NsFullEuler_nsElimSubst_viscous
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i : Fin 3) :
    nsElimHom k n (nsResPoly nu p i)
      = C Complex.I * liftParcel p (fourierAdvect k i) + liftParcel p (fourierVisc nu k i) := by

  rw [nsResPoly, map_add, map_add, nsElimSubst_advect, nsElimSubst_pressure,
    nsElimSubst_viscous, fourierVisc, map_add]
  ring
