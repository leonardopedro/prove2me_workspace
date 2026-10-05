-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — solution of BookProof.KoopmanLyapunov.kvnGenOp_symmetricOn
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Theorems.Thm_BookProof_KoopmanLyapunov_kvnGen_polySym
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_symmetricOn_op
open BookProof.KoopmanLyapunov




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {G : Fin d → MvPolynomial (Fin d) ℂ} (hG : ∀ i, RealCoeff (G i)) :
    SymmetricOn (polyGaussCore (d := d)) (kvnGenOp G) := (coreRepPoly d).symmetricOn_op (kvnGen_polySym hG)
