-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.geoHop_col
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterA4
open BookProof.NavierStokesFlow.DiagonalEsa
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow.LpNat

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}



open Finset

noncomputable section

theorem BookProof.CarlemanUnboundedHop.geoHop_col {b : ℕ → ℝ} {rho : ℝ} (hrho : 0 ≤ rho) (hrho1 : rho < 1) (k : ℕ) :
    Memℓp (fun n => geoHop b rho n k) 2 := by sorry
