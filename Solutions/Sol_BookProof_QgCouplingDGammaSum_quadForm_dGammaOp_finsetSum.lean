-- Generated from ChapterQgCouplingDGammaSum.lean — solution of BookProof.QgCouplingDGammaSum.quadForm_dGammaOp_finsetSum
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
import Theorems.Thm_BookProof_QgCouplingDGammaSum_dGammaOp_finsetSum_col
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.QgCouplingDGammaSum




open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (s : Finset ι) (cols : ι → ℕ → (ℕ →₀ ℂ))
    (x : lpFiniteModes Conf) :
    quadForm (dGammaOp (fun k => ∑ i ∈ s, cols i k)) x
      = ∑ i ∈ s, quadForm (dGammaOp (cols i)) x := by

  rw [quadForm, dGammaOp_finsetSum_col s cols x, inner_sum, Complex.re_sum]
  rfl
