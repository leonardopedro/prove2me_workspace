-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.polyGaussCore_eq_hermiteSpan
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_span_hermiteMv
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution :
    polyGaussCore (d := d)
      = Submodule.span ℂ (Set.range fun a : Fin d →₀ ℕ => pgLp (hermiteMv a)) := by

  have hrange : (Set.range fun a : Fin d →₀ ℕ => pgLp (hermiteMv a))
      = (pgMap (d := d)) '' (Set.range (hermiteMv (d := d))) := by
    rw [← Set.range_comp]
    rfl
  rw [hrange, ← Submodule.map_span, span_hermiteMv, Submodule.map_top, polyGaussCore]
