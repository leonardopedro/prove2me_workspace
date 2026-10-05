-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.ladderRec_of_deficiency
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
import Definitions.Def_ChapterKernelBound
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.KernelBound
open BookProof.NavierStokesFlow.DiagonalEsa
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow.LpNat
open BookProof.CarlemanUnboundedHop

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}



open Finset

noncomputable section

theorem BookProof.CarlemanUnboundedHop.ladderRec_of_deficiency {a : ℕ → ℕ → ℂ} (hk : IsL2Kernel a) {z : ℂ} {w : L2N}
    (hw : ∀ v : lpFiniteModes ℕ, (inner ℂ (kernelOp hk v) (w : L2N) : ℂ)
        = z * inner ℂ (v : L2N) (w : L2N)) :
    LadderRecInf a ((w : ℕ → ℂ)) z := by sorry
