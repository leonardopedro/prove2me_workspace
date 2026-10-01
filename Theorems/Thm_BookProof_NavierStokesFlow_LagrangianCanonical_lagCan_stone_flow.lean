-- Generated from ChapterNavierStokesLagrangianCanonical.lean — theorem BookProof.NavierStokesFlow.LagrangianCanonical.lagCan_stone_flow
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.EsaClosure
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LagrangianKatoRellich
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.StoneBridge
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical

variable (nu : ℝ)


open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

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
unitary flow.**  E := by sorry
