-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.lagT_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_omega_pos
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_lagT_coreState
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_norm_coreState
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical



open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

variable (nu : ℝ)

set_option maxHeartbeats 1000000 in
q_P (lagCanData nu hnu f) rfl le_rfl
    (fun v => by simp only [lagCanData]; simp; first | rfl | exact? | done)
    (lagCan_secondOrder_hasZeroDeficiencyOn nu hnu f)

theorem solution (β : Vel) : ‖((coreState β : lpF :=
  initeModes Vel) : L2I Vel)‖ = 1 := by
    have : ‖((coreState β : lpFiniteModes Vel) : L2I Vel)‖ = ‖(1 : ℂ)‖ :=
      lp.norm_single (by norm_num) β 1
    simpa using this
  
  /-- **The canonical Lagrangian second-order part is unbounded**: its essential
  self-adjointness is not a boundedness phenomenon. -/
  theorem lagT_not_bounded (hnu : 0 < nu) :
      ¬ ∃ C : ℝ, ∀ v : lpFiniteModes Vel,
        ‖(lagT nu v : L2I Vel)‖ ≤ C * ‖(v : L2I Vel)‖ := by
    rintro ⟨C, hC⟩
    have hw : 0 < omega nu := omega_pos nu hnu
    set n : ℕ := ⌈|C| / (3 * omega nu)⌉₊ + 1 with hn
    have h3 : 0 < 3 * omega nu := by linarith
    have hn1 : |C| / (3 * omega nu) + 1 ≤ (n : ℝ) := by
      have := Nat.le_ceil (|C| / (3 * omega nu))
      rw [hn]
      push_cast
      linarith
    have hdiv : |C| / (3 * omega nu) * (3 * omega nu) = |C| := div_mul_cancel₀ _ (ne_of_gt h3)
    have hmul : (|C| / (3 * omega nu) + 1) * (3 * omega nu) ≤ (n : ℝ) * (3 * omega nu) :=
      mul_le_mul_of_nonneg_right hn1 (le_of_lt h3)
    have hbig : C < 3 * omega nu * (n : ℝ) := by
      have hCa : C ≤ |C| := le_abs_self C
      nlinarith [hmul, hdiv]
    have hb := hC (coreS
