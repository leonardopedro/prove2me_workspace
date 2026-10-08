-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — solution of BookProof.KoopmanLyapunov.lyapunovComparison_symmetricOn
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Theorems.Thm_BookProof_KoopmanLyapunov_kvnGenOp_symmetricOn
import Theorems.Thm_BookProof_KoopmanLyapunov_mulCoreOp_symmetricOn
open BookProof.KoopmanLyapunov




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {G : Fin d → MvPolynomial (Fin d) ℂ}
    (hG : ∀ i, RealCoeff (G i)) {E : MvPolynomial (Fin d) ℂ} (hE : RealCoeff E) :
    SymmetricOn (polyGaussCore (d := d)) (lyapunovComparison G E) :=
  symmetricOn_square_comparison (kvnGenCore G) _ (kvnGenOp_symmetricOn hG)
      (mulCoreOp_symmetricOn hE)
