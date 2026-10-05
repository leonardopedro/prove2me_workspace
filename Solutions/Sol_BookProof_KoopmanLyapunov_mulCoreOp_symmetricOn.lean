-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — solution of BookProof.KoopmanLyapunov.mulCoreOp_symmetricOn
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_symmetricOn_op
import Theorems.Thm_BookProof_YangMillsHermite_mulOp_polySym
open BookProof.KoopmanLyapunov




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {E : MvPolynomial (Fin d) ℂ} (hE : RealCoeff E) :
    SymmetricOn (polyGaussCore (d := d)) (mulCoreOp E) := (coreRepPoly d).symmetricOn_op (mulOp_polySym hE)
