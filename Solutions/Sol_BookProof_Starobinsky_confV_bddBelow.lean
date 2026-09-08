-- Generated from ChapterStarobinskyPotential.lean — solution of BookProof.Starobinsky.confV_bddBelow
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
import Theorems.Thm_BookProof_Starobinsky_confV_ge
open BookProof.Starobinsky












open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {M alpha : ℝ} (halpha : 0 < alpha) :
    BddBelow (Set.range fun Rc => confV M alpha Rc) := ⟨-(M ^ 4 / (16 * alpha)), by rintro _ ⟨Rc, rfl⟩; exact confV_ge halpha Rc⟩
