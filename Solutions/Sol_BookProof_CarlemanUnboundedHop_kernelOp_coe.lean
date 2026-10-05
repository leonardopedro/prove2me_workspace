-- Generated from ChapterCarlemanUnboundedHop.lean — solution of BookProof.CarlemanUnboundedHop.kernelOp_coe
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop




open Finset

noncomputable section

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {a : ℕ → ℕ → ℂ} (hk : IsL2Kernel a) (f : lpFiniteModes ℕ) :
    ((kernelOp hk f : L2N) : ℕ → ℂ) = kernelFun a ((f : L2N) : ℕ → ℂ) := rfl
