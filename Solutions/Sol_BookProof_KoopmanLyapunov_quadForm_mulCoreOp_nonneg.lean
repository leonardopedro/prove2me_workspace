-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — solution of BookProof.KoopmanLyapunov.quadForm_mulCoreOp_nonneg
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Theorems.Thm_BookProof_KoopmanLyapunov_quadForm_mulCoreOp
open BookProof.KoopmanLyapunov




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {E : MvPolynomial (Fin d) ℂ}
    (hE : ∀ y : Vd d, 0 ≤ (MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ)) E).re)
    (x : polyGaussCore (d := d)) : 0 ≤ quadForm (mulCoreOp E) x := by

  rw [quadForm_mulCoreOp]
  have h := gpair_mul_mono (g := 0) (s := E) (fun y => by simpa using hE y)
    ((coreRepPoly d).equiv.symm x)
  simpa [gpair, gaussInt] using h
