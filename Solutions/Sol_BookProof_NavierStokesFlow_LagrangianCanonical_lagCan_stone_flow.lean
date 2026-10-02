-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.lagCan_stone_flow
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_lagCan_esa
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical



open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

variable (nu : ℝ)

set_option maxHeartbeats 1000000 in
te (fun _ => n))
  rw [lagT_coreState nu, norm_coreState] at hb
  have hlam : lagLam nu (fun _ => n) = 3 * omega nu * (n : ℝ) + 3 * omega nu / 2 := by
    simp only [lagLam, Fin.sum_univ_three]
    ring
  rw [hlam] at hb
  simp only [Submodule.coe_smul, norm_smul, Complex.norm_real, Real.norm_eq_abs,
    norm_coreState, mul_one] at hb
  have hpos : 0 ≤ 3 * omega nu * (n : ℝ) + 3 * omega nu / 2 := by positivity
  rw [abs_of_nonneg hpos] at hb
  linarith

open BookProof.ChapterStoneResolvent BookProof.StoneBridge BookProof.EsaClosure in
/-- **The canonical Lagrangian Navier–Stokes Hamiltonian generates a complete
unitary flow.**  E :=
  ssential self-adjointness on the trajectory-space Hermite core
  selects the unique self-adjoint extension, and Stone's theorem turns it into the
  global group `e^{-itT}` solvi
