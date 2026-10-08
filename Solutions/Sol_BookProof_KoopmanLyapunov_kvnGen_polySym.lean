-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — solution of BookProof.KoopmanLyapunov.kvnGen_polySym
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Theorems.Thm_BookProof_YangMillsHermite_momOp_polySym
import Theorems.Thm_BookProof_YangMillsHermite_mulOp_polySym
import Theorems.Thm_BookProof_YangMillsHermite_weylProd_polySym
open BookProof.KoopmanLyapunov




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {G : Fin d → MvPolynomial (Fin d) ℂ} (hG : ∀ i, RealCoeff (G i)) :
    PolySym (kvnGen G) := polySym_sum fun i _ => weylProd_polySym (momOp_polySym i) (mulOp_polySym (hG i))
