-- Generated from ChapterDegSchrodingerCore.lean — solution of BookProof.DegSchrodinger.hamCoreS_coeFn
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Theorems.Thm_BookProof_DegSchrodinger_hamCoreS_pgLp
import Theorems.Thm_BookProof_QgHermiteFriedrichs_potLp_coeFn
open BookProof.DegSchrodinger




open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (W : Vd d → ℝ) (hWc : Continuous W) (hWb : ExpBounded W)
    (S : Finset (Fin d)) (p : MvPolynomial (Fin d) ℂ) :
    ((hamCoreS W hWc hWb S ⟨pgLp p, pgLp_mem_core p⟩ : L2d d) : Vd d → ℂ)
      =ᵐ[volume] fun z => pgFun (kinPolyS S p) z + ((W z : ℝ) : ℂ) * pgFun p z := by

  rw [hamCoreS_pgLp]
  filter_upwards [Lp.coeFn_add (pgLp (kinPolyS S p)) (potLp W hWc hWb p),
    pgLp_coeFn (kinPolyS S p), potLp_coeFn W hWc hWb p] with z h1 h2 h3
  simp only [hamPolyS]
  rw [h1, Pi.add_apply, h2, h3]
