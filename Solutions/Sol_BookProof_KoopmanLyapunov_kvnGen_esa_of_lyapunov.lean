-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — solution of BookProof.KoopmanLyapunov.kvnGen_esa_of_lyapunov
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Theorems.Thm_BookProof_KoopmanLyapunov_kvnGenOp_symmetricOn
import Theorems.Thm_BookProof_KoopmanLyapunov_mulCoreOp_symmetricOn
import Theorems.Thm_BookProof_KoopmanLyapunov_quadForm_mulCoreOp_nonneg
import Theorems.Thm_BookProof_KoopmanLyapunov_commForm_kvnGen_mul_bound
open BookProof.KoopmanLyapunov




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {G : Fin d → MvPolynomial (Fin d) ℂ}
    (hG : ∀ i, RealCoeff (G i)) {E : MvPolynomial (Fin d) ℂ} (hE : RealCoeff E) {c : ℝ}
    (hc : 0 ≤ c)
    (hEpos : ∀ y : Vd d, 0 ≤ (MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ)) E).re)
    (hflux : ∀ y : Vd d, |(MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ))
      (∑ i, G i * pderiv i E)).re| ≤ c * (MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ)) E).re)
    (hN : EssentiallySelfAdjointOn (polyGaussCore (d := d)) (lyapunovComparison G E)) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (kvnGenOp G) :=
  essentiallySelfAdjointOn_of_square_comparison polyGaussCore_dense (kvnGenCore G)
      (mulCoreOp E) c (kvnGenOp_symmetricOn hG) (mulCoreOp_symmetricOn hE) hc
      (quadForm_mulCoreOp_nonneg hEpos) (commForm_kvnGen_mul_bound hG hE hflux) hN
