-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.kernelOp_coe
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
import Definitions.Def_ChapterKernelBound
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterA4
open BookProof.KernelBound
open BookProof.NavierStokesFlow.DiagonalEsa
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow.LpNat

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}



open Finset

noncomputable section

theorem BookProof.CarlemanUnboundedHop.kernelOp_coe {a : ℕ → ℕ → ℂ} (hk : IsL2Kernel a) (f : lpFiniteModes ℕ) :
    ((kernelOp hk f : L2N) : ℕ → ℂ) = kernelFun a ((f : L2N) : ℕ → ℂ) := by sorry
