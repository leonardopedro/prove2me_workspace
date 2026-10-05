-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.geoHop_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterKernelBound
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.KernelBound
open BookProof.CarlemanUnboundedHop

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}



open Finset

noncomputable section

theorem BookProof.CarlemanUnboundedHop.geoHop_essentiallySelfAdjoint (b : ℕ → ℝ) {rho : ℝ} (hrho : 0 ≤ rho)
    (hrho1 : rho < 1) :
    EssentiallySelfAdjointOn (lpFiniteModes ℕ) (kernelOp (geoHop_isL2Kernel b hrho hrho1)) := by sorry
